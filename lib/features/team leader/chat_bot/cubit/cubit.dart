import 'package:equatable/equatable.dart';


abstract class ChatBotEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends ChatBotEvent {
  final String message;

  SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}
