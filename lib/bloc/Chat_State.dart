import 'package:app_syng_task/Models/ChatMessage.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChatState extends Equatable {}

class ChatInitialState extends ChatState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatLoadingState extends ChatState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatLoadedState extends ChatState {

  List<TextMessageModel> messages;
  ChatLoadedState({@required this.messages});

  @override
  // TODO: implement props
  List<Object> get props => [messages];
}


class ChatErrorState extends ChatState {

  String message;
  ChatErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
