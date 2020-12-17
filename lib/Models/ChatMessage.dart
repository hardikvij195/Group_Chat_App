import 'package:app_syng_task/pages/ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ChatMessage{
  String message , UserName , Uid;
  MessageType type;
  Timestamp time ;
  ChatMessage({@required this.message, @required this.UserName, @required this.Uid, @required this.type});
}


class TextMessageEntity extends Equatable{

  final String senderName;
  final String senderUid;
  final Timestamp time;
  final String message;
  TextMessageEntity( this.senderUid, this.senderName,this.time, this.message, );

  @override
  // TODO: implement props
  List<Object> get props => [senderUid, senderName, time, message, ];

}

class TextMessageModel extends TextMessageEntity {
  TextMessageModel({String senderUid, String senderName, Timestamp time, String message})
      : super(senderUid, senderName , time, message);

  factory TextMessageModel.fromJson(Map<String,dynamic> json){
    return TextMessageModel(
      message:json['message'],
      time: json['time'],
      senderUid:json['senderUid'],
      senderName:json['senderName'],
    );
  }

  factory TextMessageModel.fromSnapshot(DocumentSnapshot documentSnapshot){
    return TextMessageModel(
      time: documentSnapshot.data()['time'],
      message:documentSnapshot.data()['message'],
      senderUid:documentSnapshot.data()['senderUid'],
      senderName:documentSnapshot.data()['senderName'],
    );
  }

  Map<String,dynamic> toDocument(){
    return {
      "senderUid":senderUid,
      "senderName":senderName,
      "time":time,
      "message":message,
    };
  }
}