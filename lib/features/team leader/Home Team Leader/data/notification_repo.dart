import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_model.dart';

class NotificationRepository {
  final ApiServicepublic _apiService = ApiServicepublic(); // نفترض استخدام ApiService الأساسي

  Future<List<NotificationModel>> getNotifications() async {
    final response = await _apiService.get('/api/Notifications'); // المسار من صورة Postman
    return (response as List).map((e) => NotificationModel.fromJson(e)).toList();
  }
  Future<dynamic> patchMarkAsRead(String id) async {
    try {
      // بناءً على صورة الـ Postman، المسار هو /api/Notifications/{id}/mark-as-read
      final response = await _apiService.patch('/api/Notifications/$id/mark-as-read',{});
      return response.data;
    } on DioException catch (e) {
      throw ApiException();
    }
  }
  Future<int> getUnreadCount() async {
    // المسار من صورة image_cc48d0.png
    final response = await _apiService.get('/api/Notifications/unread-count');
    return response['count'];
  }
}