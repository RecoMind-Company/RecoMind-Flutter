import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';

class AddTaskRequestModel {
  final String title;
  final String description;
  final int status;
  final int priority;
  final String startDate;
  final String deadLine;
  final String? moduleId;
  final String? planId;
  final List<String> userIds;

  AddTaskRequestModel({
    required this.title,
    required this.description,
    this.status = 0,
    this.priority = 0,
    required this.startDate,
    required this.deadLine,
    this.moduleId,
    this.planId,
    required this.userIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'startDate': startDate,
      'deadLine': deadLine,
      'moduleId': moduleId,
      'planId': planId,
      'userIds': userIds,
    };
  }
}

class AddTaskToPlanResponseModel {
  final String? message;
  final bool? isSuccess;

  AddTaskToPlanResponseModel({
    this.message,
    this.isSuccess,
  });

  factory AddTaskToPlanResponseModel.fromJson(Map<String, dynamic> json) {
    return AddTaskToPlanResponseModel(
      message: json['message'] as String?,
      isSuccess: json['isSuccess'] as bool?,
    );
  }
}

class AddTaskToPlanRepository {
  final ApiServicepublic _apiServiceTeam = ApiServicepublic();

  Future<dynamic> addTaskToPlan(AddTaskRequestModel requestModel) async {
    // تأكد من صحة هذا المسار بناءً على الـ Swagger/API Docs لتجنب الـ 404
    final response = await _apiServiceTeam.post(
      '/api/tasks/personal',
      requestModel.toJson(),
    );
    print(requestModel.toJson());
     // print(response);
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