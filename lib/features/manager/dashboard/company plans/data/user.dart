import 'package:dartz/dartz.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';

class UserRepository {
  // استخدام الـ ApiService الموحد في المشروع
  final ApiServicepublic _apiService = ApiServicepublic();

  /// جلب بيانات المستخدم كاملة باستخدام الـ userId
  Future<Either<ApiError, UserModel>> getUser({required String userId}) async {
    try {
      final response = await _apiService.get(
          "/api/users/getJobTitle/$userId"
      );

      print("User response status/data: $response");

      if (response is ApiError) {
        return Left<ApiError, UserModel>(response);
      }

      if (response is Map<String, dynamic>) {
        final userModel = UserModel.fromJson(response);
        return Right<ApiError, UserModel>(userModel);
      }

      return Left<ApiError, UserModel>(
        ApiError(message: "Unexpected response format from user API"),
      );
    } catch (e) {
      if (e is ApiError) {
        return Left<ApiError, UserModel>(e);
      }
      return Left<ApiError, UserModel>(ApiError(message: e.toString()));
    }
  }
}

// =========================================================================
// 💡 الموديل المحدث بالكامل ليقرأ الـ userName والـ jobTitle من السيرفر
// =========================================================================
class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final int? status;
  final String? jobTitle; // 👈 حقل المسمى الوظيفي

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.status,
    this.jobTitle,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['userId'] ?? json['id']) as String?,
      name: (json['userName'] ?? json['name']) as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      status: json['status'] as int?,
      jobTitle: json['jobTitle'] as String?, // 👈 قراءة الـ jobTitle من الـ Log
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'userId': id,
      if (name != null) 'userName': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (jobTitle != null) 'jobTitle': jobTitle,
    };
  }
}