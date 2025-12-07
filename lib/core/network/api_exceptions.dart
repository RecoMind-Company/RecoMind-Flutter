import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';

class ApiException{
  static ApiError handleError(DioError error){
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String message;

    if (data is Map<String,dynamic> && data["errorMessage"] != null) {
      message = data["errorMessage"];
    } else if (statusCode != null) {
      message = 'Request failed with status code $statusCode';
    } else {
      message = error.message ?? 'Something went wrong';
    }

    return ApiError(message: message, statusCode: statusCode, data: data);
  }

}