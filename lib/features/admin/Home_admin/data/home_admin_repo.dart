import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/admin/Home_admin/data/home_admin_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';

class HomeAdminRepo {
  final ApiServiceSetup _apiServiceSetup = ApiServiceSetup();
  final ApiServicepublic _apiServicePublic = ApiServicepublic();

  Future<setupModel> getSetup() async {
    try {
      final response = await _apiServiceSetup.get("/GetByAdminId");

      if (response is ApiError) throw response;

      final dynamic data = response is Response ? response.data : response;

      if (data is List && data.isNotEmpty) {
        return setupModel.fromJson(data.last);
      } else if (data is Map<String, dynamic>) {
        return setupModel.fromJson(data);
      }

      throw ApiError(message: "لم يتم العثور على بيانات الشركة");
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      throw ApiError(message: "حدث خطأ غير متوقع أثناء جلب بيانات الشركة");
    }
  }

  Future<List<InvitationModel>> getInvitationsByStatus({
    required String status,
    required String companyId,
  }) async {
    try {
      final queryParams = {
        'Status': status,
        'companyId': companyId,
      };

      print("======== [START API CALL] ========");
      print("Sending Request to /api/Invitation/byStatus with params: $queryParams");

      // ✨ تم الإصلاح: استقبال النتيجة كـ dynamic لأن السيرفس عندك بيرجع response.data مباشرة
      final dynamic rawData = await _apiServicePublic.get(
        '/api/Invitation/byStatus',
        queryParameters: queryParams,
      );

      // طالما وصلنا للسطر ده ومنتقلش للـ catch، يبقى كود الحالة 200 OK بنسبة 100%
      print("🔵 HTTP STATUS CODE: 200 OK (Request Succeeded)");
      print("🟢 RAW DATA TYPE: ${rawData.runtimeType}");
      print("🟢 RAW DATA BODY: $rawData");
      print("==================================");

      if (rawData is List) {
        return rawData.map((json) => InvitationModel.fromJson(json)).toList();
      } else if (rawData is Map && rawData['data'] is List) {
        return (rawData['data'] as List)
            .map((json) => InvitationModel.fromJson(json))
            .toList();
      }

      return [];
    } on DioException catch (e) {
      print("====== ❌ DIO ERROR DETECTED ======");
      print("❌ HTTP STATUS CODE (ERROR): ${e.response?.statusCode}");
      print("❌ ERROR MESSAGE: ${e.message}");
      print("❌ ERROR RESPONSE DATA: ${e.response?.data}");
      print("==================================");
      throw ApiException.handleError(e);
    } catch (e) {
      print("❌ UNEXPECTED CRASH IN REPO: $e");
      throw ApiError(message: "فشل في معالجة بيانات الدعوات الحالية");
    }
  }
  Future<List<InvitationModel>> getAcceptedInvitations(String companyId) =>
      getInvitationsByStatus(status: 'Accepted', companyId: companyId);

  Future<List<InvitationModel>> getExpiredInvitations(String companyId) =>
      getInvitationsByStatus(status: 'Expired', companyId: companyId);

  Future<List<InvitationModel>> getPendingInvitations(String companyId) =>
      getInvitationsByStatus(status: 'Pending', companyId: companyId);

  Future<List<InvitationModel>> getRejectedInvitations(String companyId) =>
      getInvitationsByStatus(status: 'Rejected', companyId: companyId);
}