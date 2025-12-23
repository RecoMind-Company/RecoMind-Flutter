import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/cubit.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/state.dart';
import 'package:recomind/features/team%20leader/chat_bot/data/chatbot_repo.dart';


class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final ChatbotRepo repo;

  ChatBotBloc(this.repo) : super(ChatBotInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(ChatBotLoading());
      try {
        // إنشاء الاستعلام
        final query = await repo.create1Query(event.message);

        // انتظار الرد من الباكيند لحد ما يكون SUCCESS
        final response = await repo.ChatResponse(
          taskID: query.task_id!,
          user_question: query.user_question!,
        );

        emit(ChatBotLoaded(response.response!));

      } catch (e) {
        emit(ChatBotError(e.toString()));
      }
    });
  }
}
