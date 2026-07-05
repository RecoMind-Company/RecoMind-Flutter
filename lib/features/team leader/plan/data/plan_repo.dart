import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/plan/data/plan_model.dart';

class ActionPlanRepository {
  final ApiServicepublic _apiService = ApiServicepublic();

  Future<ActionPlanResponse> getActionPlanById(String reportId) async {
    final String endPoint = "api/Report/get/$reportId";

    final response = await _apiService.get(endPoint);
    print(response);
    if (response is ApiError) {
      throw response;
    }

    if (response is Map<String, dynamic>) {
      return ActionPlanResponse.fromJson(response);
    }

    throw ApiError(
      message: "Failed to load action plan. Unexpected data format.",
    );
  }

  /// 1. validation (POST)
  Future<ValidationReportResponse> generateCustomPlanvalidation(String descriptionInput) async {
    const String endPoint = '/api/ValidationReport/generate';

    final Map<String, dynamic> body = {
      "userRequest": descriptionInput,
    };

    final response = await _apiService.post(endPoint, body);

    if (response is Map<String, dynamic>) {
      return ValidationReportResponse.fromJson(response);
    } else {
      throw response;
    }
  }

  /// 2. get generated (GET)
  Future<ValidationContentModel> fetchValidationPlanResult(String taskId) async {
    final response = await _apiService.get('/api/ValidationReport/generated/$taskId');
    print("this is response $response");

    if (response is ApiError) {
      throw response;
    }
    print("this is response $response");
    return ValidationContentModel.fromJson(response as Map<String, dynamic>);
  }

  /// 3. save generated (POST)
  Future<SaveValidationResponseModel> addValidationReport(SaveValidationRequestModel requestBody) async {
    const String endPoint = '/api/ValidationReport/add';

    final response = await _apiService.post(endPoint, requestBody.toJson());
    print("this is response 2 $response");

    if (response is ApiError) {
      throw response;
    }
    print("this is response $response");
    if (response is Map<String, dynamic>) {
      return SaveValidationResponseModel.fromJson(response);
    }
    throw ApiError(
      message: "Failed to save validation report. Unexpected data format.",
    );
  }
}