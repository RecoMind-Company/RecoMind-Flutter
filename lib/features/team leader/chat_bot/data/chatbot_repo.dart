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
          throw response.message;
        }

        // ✅ حماية إضافية: لو الباكيند رجع String (Plain text خطأ من السيرفر) وليس Map
        if (response is String) {
          throw "Something went wrong, please try again.";
        }

        final user = getQuery.fromJson(response);
        print(user);

        if (user.status == "SUCCESS") {
          return user;
        }

        await Future.delayed(const Duration(seconds: 20));

      } on DioException catch (e) {
        throw "Something went wrong, please try again.";
      } catch (e) {
        throw "Something went wrong, please try again.";
      }
    }
  }
    Future<List<ChatBotHistoryModel>> getChatHistory() async {
    try {
      // استدعاء الـ Endpoint بأسلوب GET كما هو موضح بالصورة
      final response = await apiService.get("/GetHistory");

      print("History Response: $response");

      if (response is ApiError) {
        throw response.message;
      }

      // بما أن السيرفر يرجع List مباشرة [ {...}, {...} ]
      if (response is List) {
        return ChatBotHistoryModel.fromJsonList(response);
      } else {
        throw "Unexpected data format received.";
      }

    } on DioException catch (e) {
      print("Dio Error in history: $e");
      throw "Something went wrong, please try again.";
    } catch (e) {
      print("Parsing Error in history: $e");
      throw "Something went wrong, please try again.";
    }
  }
}