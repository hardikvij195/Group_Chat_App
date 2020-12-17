import 'dart:async';

import 'package:app_syng_task/Models/ChatMessage.dart';
import 'package:app_syng_task/Widgets/ChatWidget.dart';
import 'package:app_syng_task/pages/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MessageType{
  Sender,
  Receiver,
}

class ChatScreen extends StatefulWidget {

  String UserName , UserId;
  ChatScreen( this.UserId , this.UserName );

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {



  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final ChatCollection = FirebaseFirestore.instance.collection("Chat");



  TextEditingController textEditingController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("Uid - " +  widget.UserId);
    print("Name - " +  widget.UserName);
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds: 1),
          () => _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          ),
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Group Chat"),
        centerTitle: true,
        leading: InkWell(
            onTap: (){

              auth.signOut().whenComplete(() {

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);

              });

            },
            child: Icon(Icons.logout)),
      ),
      body: Stack(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 100),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Chat').orderBy("time").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print("Length -- " + snapshot.data.docs.length.toString());

                  // return Container(
                  //
                  // );
                  return ListView.builder(
                    controller: _controller,
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context , index){
                      print("Uid -- " + snapshot.data.docs[index].data()['senderUid']);
                      if(widget.UserId == snapshot.data.docs[index].data()['senderUid']){
                        print("Sender");
                      }else{
                        print("Reciever");
                      }

                      return ChatBubble(
                            chatMessage: ChatMessage( message: snapshot.data.docs[index].data()['message'] ,
                                UserName: snapshot.data.docs[index].data()['senderName'] ,
                              Uid: snapshot.data.docs[index].data()['senderUid'],
                              type: snapshot.data.docs[index].data()['senderUid'] == widget.UserId ? MessageType.Sender : MessageType.Receiver
                            ),
                          );
                    },
                  );
                }
            ),
          ),
          // ListView.builder(
          //   itemCount: chatMessage.length,
          //   shrinkWrap: true,
          //   padding: EdgeInsets.only(top: 10,bottom: 10),
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index){
          //     return ChatBubble(
          //       chatMessage: chatMessage[index],
          //     );
          //   },
          // ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16,bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none
                      ),
                      controller: textEditingController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 30,bottom: 50),
              child: FloatingActionButton(
                onPressed: (){

                  SendMessage(textEditingController.text.trim() , widget.UserId , widget.UserName);


                },
                child: Icon(Icons.send,color: Colors.white,),
                backgroundColor: Colors.pink,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );


  }

  void SendMessage(String Message , String Uid , String UName){

    // print("Uid - " + Uid);
    // print("Name - " + UName);

    final newMessage = TextMessageModel(
      message: Message,
      time: Timestamp.now(),
      senderUid: Uid,
      senderName: UName,
    );

    print(newMessage.toDocument());

    ChatCollection.add(newMessage.toDocument());

    textEditingController.clear();

    Timer(
      Duration(seconds: 1),
          () => _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );

  }



}