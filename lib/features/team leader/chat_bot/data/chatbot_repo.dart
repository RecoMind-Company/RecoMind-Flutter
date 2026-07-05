import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/chat_bot/data/chatbot_model.dart';

import 'chatbot_model.dart';

class ChatbotRepo {
  String? taskId, user_question;
  ApiServiceChatBot apiService = ApiServiceChatBot();

  Future<createQuery> create1Query(String question) async {
    try {
      final response = await apiService.post(
        "/CreateQuery",
        {
          "question": question,
        },
      );
      print("this is first response $response");
      return createQuery.fromJson(response);
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    } on ApiError catch (e) {
      throw e.message;
    }
  }

  Future<getQuery> ChatResponse({
    required String taskID,
    required String user_question,
  }) async {
    while (true) {
      try {
        final response = await apiService.post("/ChatbotResponse", {
          "taskId": taskID,
          "user_question": user_question,
        });
        print("this is second response $response");
        if (response is ApiError) {
          throw response;
        }

        final user = getQuery.fromJson(response);
        print(user);

        if (user.status == "SUCCESS") {
          return user;
        }

        await Future.delayed(Duration(seconds: 20));

      } on DioError catch (e) {
        throw ApiException.handleError(e);
      } on ApiError catch (e) {
        throw e.message;
      }
    }
  }
}