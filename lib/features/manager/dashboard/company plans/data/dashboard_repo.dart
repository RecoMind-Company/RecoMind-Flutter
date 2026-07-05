import 'package:flutter/material.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';

class PlanRepository {
  final ApiServicepublic _apiService;

  PlanRepository({ApiServicepublic? apiService}) : _apiService = apiService ?? ApiServicepublic();

  // =========================================================================
  // 1. إرسال طلب إنشاء الخطة المخصصة (Custom Plan Generation)
  // =========================================================================
  Future<PlanResponse> generateCustomPlan(String description) async {
    try {
      debugPrint("----------------------------------------");
      debugPrint("This is description: $description");
      debugPrint("Sending generated custom plan...");

      final response = await _apiService.post(
        '/api/Plan/custom-plan/generate',
        {
          'description': description,
        },
      );

      debugPrint('✅ Success Response Received:');
      debugPrint(response.toString());
      return PlanResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // =========================================================================
  // 2. جلب نتيجة الخطة المخصصة بناءً على الـ Task ID (الـ Polling)
  // =========================================================================
  Future<PlanResponse> getCustomPlanResult(String taskId) async {
    try {
      final response = await _apiService.post(
        '/api/Plan/custom-plan/result',
        {
          'taskId': taskId,    // الـ CamelCase الافتراضي للدرفتس
          'task_id': taskId,   // الـ Snake_Case تأميناً إذا كان السيرفر صارم في التسمية
        },
      );

      return PlanResponse.fromJson(response);
    } catch (e, stackTrace) {
      // 🔴 طباعة تفاصيل الخطأ في الـ Console لتسهيل معالجته أثناء الـ Debugging
      debugPrint('================ 🚨 CUSTOM PLAN ERROR 🚨 ================');
      debugPrint('Exception Caught: $e');
      debugPrint('Stack Trace:\n$stackTrace');
      debugPrint('=========================================================');
      rethrow;
    }
  }
///approved
  Future<void> approvePlan({
    required String planId,
  }) async {
    try {
      final requestModel = PlanApprovalRequest(
        planId: planId,
        isApproved: true,
        feedback: "string",
        status: "Accepted",
      );

      debugPrint("Sending Plan Approval for ID: $planId");

      await _apiService.post(
        '/api/Plan/IsApproved',
        requestModel.toJson(),
      );

      debugPrint("✅ Plan Approved & Dispatched Successfully!");
    } catch (e) {
      debugPrint("❌ Failed to approve plan: $e");
      rethrow;
    }
  }
  // =========================================================================
  // 3. بقية دوال جلب خطط وتاسكات الشركة (Company Plans & Tasks)
  // =========================================================================
  Future<List<CompanyPlanResponseItem>> fetchCompanyPlans() async {
    try {
      final responseData = await _apiService.get('/api/Plan/GetAll');

      if (responseData is List) {
        return responseData
            .map((e) => CompanyPlanResponseItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Expected a List from API response');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ReportDetailResponse> fetchPlanById(String reportID) async {
    try {
      final responseData = await _apiService.get('/api/Report/get/$reportID');

      if (responseData is Map<String, dynamic>) {
        return ReportDetailResponse.fromJson(responseData);
      } else {
        throw Exception('Invalid response format: Expected an Object');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskModel>> fetchTasksByModule({required String planId, required String moduleId}) async {
    try {
      final responseData = await _apiService.get(
        '/api/tasks/$planId/all',
      );

      if (responseData is List) {
        return responseData.map((json) => TaskModel.fromJson(json as Map<String, dynamic>)).toList();
      } else if (responseData is Map<String, dynamic> && responseData['value'] is List) {
        final List list = responseData['value'];
        return list.map((json) => TaskModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  //////////////////////////////////////////////////////
///update
///////////////////////////////////////////////////////
  Future<bool> updateTask({
    required String questId,
    required UpdateTaskRequest request,
  }) async {
    try {
      final endpoint = '/api/tasks/update/$questId';
      final body = request.toJson();

      debugPrint("🚀 Sending Update Request to: $endpoint");
      debugPrint("📦 Payload: $body"); // هنا ستعرف إذا كانت البيانات تصل بشكل صحيح

      final response = await _apiService.patch(endpoint, body);

      debugPrint("✅ Response from API: $response");
      return true;
    } catch (e) {
      debugPrint('❌ Error updating task: $e');
      rethrow;
    }
  }
  /// delete
  Future<bool> deleteTask({required String questId}) async {
    try {
      await _apiService.delete('/api/tasks/delete/$questId', {});
      return true;
    } catch (e) {
      rethrow;
    }
  }
}