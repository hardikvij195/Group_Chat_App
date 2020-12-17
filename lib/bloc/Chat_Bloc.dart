import 'package:app_syng_task/Models/ChatMessage.dart';
import 'package:app_syng_task/bloc/Chat_Event.dart';
import 'package:app_syng_task/bloc/Chat_State.dart';
import 'package:app_syng_task/repo/Chat_Repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Chat_Bloc extends Bloc<ChatEvent, ChatState> {

  ChatRepository repository;
  Chat_Bloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  ChatState get initialState => ChatInitialState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is FetchChatEvent) {
      yield ChatLoadingState();
      try {
        //List<ChatMessage> messages = await repository.getTracks();
        //yield ChatLoadedState(messages: messages);
      } catch (e) {
        yield ChatErrorState(message: e.toString());
      }
    }
  }

}