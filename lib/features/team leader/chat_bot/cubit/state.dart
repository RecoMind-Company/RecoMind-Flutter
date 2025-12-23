import 'package:recomind/features/team%20leader/chat_bot/data/chatbot_model.dart';
import 'package:equatable/equatable.dart';


abstract class ChatBotState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {}

class ChatBotLoaded extends ChatBotState {
  final String response;

  ChatBotLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class ChatBotError extends ChatBotState {
  final String message;

  ChatBotError(this.message);

  @override
  List<Object?> get props => [message];
}
