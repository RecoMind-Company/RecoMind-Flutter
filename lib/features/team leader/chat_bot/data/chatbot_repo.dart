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

  /// create Query
  Future<createQuery> create1Query(String question) async {
    try {
      final response = await apiService.post("/CreateQuery",
        jsonEncode(
          question,  // أو "question" حسب الـ DTO في الـ backend
        ),
      );
      print(response);
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

        if (response is ApiError) {
          throw response;
        }

        final user = getQuery.fromJson(response);
        print(user);

        // تحقق من حالة النجاح
        if (user.status == "SUCCESS") {
          return user;
        }

        // لو لسه مش SUCCESS ننتظر 20 ثانية قبل المحاولة التالية
        await Future.delayed(Duration(seconds: 20));

      } on DioError catch (e) {
        throw ApiException.handleError(e);
      } on ApiError catch (e) {
        throw e.message;
      }
    }
  }



}
