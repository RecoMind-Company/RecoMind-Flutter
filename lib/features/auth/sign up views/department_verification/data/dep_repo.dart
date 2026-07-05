import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/data/dep_model.dart';

class MappingReviewRepo {
  // كائن الـ Service المستخدم في مشروعك
  final _apiServicePublic = ApiServicepublic();

  // 📥 1. دالة جلب الجداول المراجعة (GET)
  Future<List<MappingReviewModel>> getDepartmentReviews(String deptName) async {
    try {
      print("======== [START MAPPING API CALL] ========");
      print("Request URL: /api/Mapping/review/$deptName");

      // إرسال الطلب للسيرفر
      final response = await _apiServicePublic.get('/api/Mapping/review/$deptName');

      // استخراج البيانات الخام
      final dynamic rawData = response is Response ? response.data : response;

      print("🔵 HTTP STATUS CODE: 200 OK");
      print("🟢 RAW DATA TYPE: ${rawData.runtimeType}");
      print("🟢 RAW DATA BODY: $rawData");
      print("==========================================");

      // التعامل مع الـ Response لو كان جاي كلستة مباشرة من السيرفر
      if (rawData is List) {
        return rawData.map((json) => MappingReviewModel.fromJson(json)).toList();
      }
      // التعامل مع الـ Response لو كان مغلف داخل كائن (Map) ومفتاح اسمه 'data
      else if (rawData is Map && rawData['data'] is List) {
        return (rawData['data'] as List)
            .map((json) => MappingReviewModel.fromJson(json))
            .toList();
      }

      print("⚠️ WARNING: Data received is not a list format!");
      return [];
    } on DioException catch (e) {
      print("====== ❌ DIO ERROR IN MAPPING REPO ======");
      print("❌ HTTP STATUS CODE: ${e.response?.statusCode}");
      print("❌ ERROR MESSAGE: ${e.message}");
      print("❌ RESPONSE DATA: ${e.response?.data}");
      print("==========================================");
      rethrow;
    } catch (e) {
      print("❌ UNEXPECTED CRASH IN MAPPING REPO: $e");
      throw Exception("Failed to load department reviews");
    }
  }

  // 📥 2. دالة جلب الجداول المتاحة (GET)
  Future<List<AvailableTableModel>> getAvailableTables(String deptName) async {
    try {
      print("======== [START AVAILABLE TABLES API CALL] ========");
      print("Request URL: /api/Mapping/available/$deptName");

      final response = await _apiServicePublic.get('/api/Mapping/available/$deptName');

      final dynamic rawData = response is Response ? response.data : response;

      print("🔵 HTTP STATUS CODE: 200 OK");
      print("🟢 RAW DATA TYPE: ${rawData.runtimeType}");
      print("🟢 RAW DATA BODY: $rawData");
      print("===================================================");

      if (rawData is List) {
        return rawData.map((json) => AvailableTableModel.fromJson(json)).toList();
      } else if (rawData is Map && rawData['data'] is List) {
        return (rawData['data'] as List)
            .map((json) => AvailableTableModel.fromJson(json))
            .toList();
      }

      print("⚠️ WARNING: Data received is not a list format!");
      return [];
    } on DioException catch (e) {
      print("====== ❌ DIO ERROR IN AVAILABLE TABLES REPO ======");
      print("❌ HTTP STATUS CODE: ${e.response?.statusCode}");
      print("❌ ERROR MESSAGE: ${e.message}");
      print("❌ RESPONSE DATA: ${e.response?.data}");
      print("===================================================");
      rethrow;
    } catch (e) {
      print("❌ UNEXPECTED CRASH IN AVAILABLE TABLES REPO: $e");
      throw Exception("Failed to load available tables");
    }
  }

  // 🚀 3. دالة إضافة الجداول المختارة للقسم (POST)
  Future<bool> addTablesToDepartment({
    required String companyId,
    required String deptName,
    required List<int> tableIds,
  }) async {
    try {
      print("======== [START ADD TABLES API CALL] ========");
      print("Request URL: /api/Mapping/add");

      // الـ Body المطلوب بالملي من الـ Postman
      final Map<String, dynamic> requestBody = {
        "companyId": companyId,
        "deptName": deptName,
        "tableIds": tableIds,
      };

      print("📦 REQUEST BODY: $requestBody");

      // إرسال الطلب
      final response = await _apiServicePublic.post('/api/Mapping/add', requestBody);

      // استخراج البيانات الخام
      final dynamic rawData = response is Response ? response.data : response;

      print("🔵 HTTP STATUS CODE: 200 OK");
      print("🟢 RAW DATA BODY FROM SERVER: $rawData");
      print("==========================================");

      // التحقق من أن السيرفر رجع {"success": true} بالملي
      if (rawData is Map && rawData['success'] == true) {
        print("🎉 SUCCESS: Tables added successfully according to backend!");
        return true;
      }

      print("⚠️ WARNING: Server returned 200 OK but success was false or format mismatch.");
      return false;
    } on DioException catch (e) {
      print("====== ❌ DIO ERROR IN ADD TABLES REPO ======");
      print("❌ HTTP STATUS CODE: ${e.response?.statusCode}");
      print("❌ ERROR MESSAGE: ${e.message}");
      print("❌ RESPONSE DATA: ${e.response?.data}");
      print("==========================================");
      rethrow;
    } catch (e) {
      print("❌ UNEXPECTED CRASH IN ADD TABLES REPO: $e");
      throw Exception("Failed to add tables to department");
    }
  }

  Future<bool> deleteTablesFromDepartment({
    required String companyId,
    required String deptName,
    required List<int> tableIds,
  }) async {
    try {
      print("======== [START DELETE TABLES API CALL] ========");
      print("Request URL: /api/Mapping/delete");

      // الـ Body المطلوب بالملي من الـ Postman
      final Map<String, dynamic> requestBody = {
        "companyId": companyId,
        "deptName": deptName,
        "tableIds": tableIds,
      };

      print("📦 DELETE REQUEST BODY: $requestBody");

      // ✅ الإصلاح الفعلي والمطابق لـ الـ ApiService عندك بالملي:
      // 1. الباراميتر الأول: الـ endPoint (String)
      // 2. الباراميتر الثاني: الـ requestBody مباشرة (Map) بدون كلمة body:
      // 3. الباراميتر الثالث: الـ queryParameters كـ Named ومجبورة تاخد Map حتى لو فاضية
      final response = await _apiServicePublic.delete(
        '/api/Mapping/delete',
        requestBody,
        queryParameters: const {},
      );

      final dynamic rawData = response is Response ? response.data : response;

      print("🔵 HTTP STATUS CODE: 200 OK");
      print("🔴 RAW DATA BODY FROM SERVER (DELETE): $rawData");
      print("==========================================");

      if (rawData is Map && rawData['success'] == true) {
        print("🎉 SUCCESS: Tables deleted successfully according to backend!");
        return true;
      }

      print("⚠️ WARNING: Server returned 200 OK but success was false or format mismatch on Delete.");
      return false;
    } on DioException catch (e) {
      print("====== ❌ DIO ERROR IN DELETE TABLES REPO ======");
      print("❌ HTTP STATUS CODE: ${e.response?.statusCode}");
      print("❌ ERROR MESSAGE: ${e.message}");
      print("❌ RESPONSE DATA: ${e.response?.data}");
      print("==========================================");
      rethrow;
    } catch (e) {
      print("❌ UNEXPECTED CRASH IN DELETE TABLES REPO: $e");
      throw Exception("Failed to delete tables from department");
    }
  }
}