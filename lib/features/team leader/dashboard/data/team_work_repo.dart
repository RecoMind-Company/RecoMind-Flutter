import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/dashboard/data/team_work_model.dart'; // قم بتعديل المسار حسب مشروعك

class UserTaskRepository {
  final ApiServicepublic _apiService = ApiServicepublic();

  Future<List<UserTaskModel>> getUserTasks() async {
    try {
      final response = await _apiService.get('/api/user-tasks/user-tasks');

      // إضافة سطر الطباعة هنا لرؤية الرد الخام القادم من الـ API
      print("--- Raw API Response ---");
      print(response);
      print("------------------------");

      // تحويل الـ Response إلى قائمة من UserTaskModel
      return (response as List)
          .map((item) => UserTaskModel.fromJson(item))
          .toList();
    } catch (e) {
      print("Error in Repository: $e"); // لطباعة أي خطأ يحدث أثناء الاتصال
      throw Exception("Failed to load user tasks: $e");
    }
  }

  /// add task //////////////
  Future<dynamic> addTaskToPlan(AddTaskToPlanRequestModel requestModel) async {
    final response = await _apiService.post(
      '/api/tasks/personal',
      requestModel.toJson(),
    );

    if (response is ApiError) {
      return response;
    }

    try {
      return AddTaskToPlanResponseModel.fromJson(response);
    } catch (e) {
      return ApiError(
        message: 'Parsing Error: Failed to parse response data.',
        data: e,
      );
    }
  }
}