import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';

class ChatbotRepo {
  String? taskId, user_question;
  ApiServiceChatBot apiService = ApiServiceChatBot();

  /// create Query
  Future<dynamic> createQuery(String question) async {
    try {
      final response = await apiService.post("/CreateQuery", {
        "question": question,
      });

      if (response is ApiError) {
        throw response;
      }

      // خزّن القيم زي ما إنت عامل
      taskId = response['taskId'];
      user_question = response['user_question'];

      return taskId; // ✅ أهم سطر
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    } on ApiError catch (e) {
      throw e.message;
    }
  }

  Future<dynamic> ChatResponse({
    required String taskID,
    required String user_question,
  }) async {
    try {
      final response = await apiService.post("/ChatbotResponse", {
        "taskId": taskID,
        "user_question": user_question,
      });

      if (response is ApiError) {
        throw response;
      }

      return response;
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    } on ApiError catch (e) {
      throw e.message;
    }
  }

  Future<dynamic> askChatBot(String question) async {
    final taskID = await createQuery(question); // ✅ String
    final chatResponse = await ChatResponse(
      taskID: taskID,
      user_question: question,
    );

    return chatResponse;
  }
}
