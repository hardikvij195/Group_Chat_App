import 'package:app_syng_task/Models/ChatMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class ChatRepository {
  Future<List<ChatMessage>> getChat();

}

// class ChatRepositoryImpl implements ChatRepository {
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _userCollection = FirebaseFirestore.instance.collection("users");
//   final _globalChatChannelCollection = FirebaseFirestore.instance.collection("globalChatChannel");
//
//   final String channelId = "8ghYhb9YN58qQeSBy2MG";
//
//
//   // @override
//   // Future<List<Dynamic>> getMessages() async {
//   //   //var response = await http.get(AppStrings.TracksUrl);
//   //   // if (response.statusCode == 200) {
//   //   //   var data = json.decode(response.body);
//   //   //   print(data['message']['body']);
//   //      //List<ChatMessage> messages = ApiResultModel.fromJson(data['message']['body']).tracks;
//   //   //   print(tracks);
//   //
//   //   return _globalChatChannelCollection
//   //       .doc(channelId)
//   //       .collection("messages")
//   //       .orderBy("time")
//   //       .snapshots()
//   //       .map((querySnapshot) => querySnapshot.docs
//   //       .map((docSnapshot) => TextMessageModel.fromSnapshot(docSnapshot))
//   //       .toList());
//   // }
//
//
//
//
// }