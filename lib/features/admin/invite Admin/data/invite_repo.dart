import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';

class InviteRepo {
  final ApiServicepublic _apiServicePublic = ApiServicepublic();

  Future<String> invite(String email) async {
    try {
      final response = await _apiServicePublic.post(
        "/api/Invitation/createInvitation",
        {
          "email": email,
          "reciverRole": "teamleader",
        },
      );

      // إذا كان السيرفس يعود بـ response.data مباشرة:
      final dynamic data = response is Response ? response.data : response;
      return (data['userId'] ?? "").toString();
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      throw ApiError(message: "فشل في إعادة إرسال الدعوة");
    }
  }
}