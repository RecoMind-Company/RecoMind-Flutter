import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/core/network/dio_client.dart';
import 'package:recomind/core/utils/pref_helper.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/data/signup_model.dart';

import '../../../../../core/network/api_exceptions.dart';

class SetupRepository {
  ApiService _apiService = ApiService();
  DioClient _dioClient = DioClient();
  ApiServiceInvite apiService = ApiServiceInvite();
  ApiServiceSetup apiServiceSetup = ApiServiceSetup();
  ApiServiceDB apiServiceDB = ApiServiceDB();


  ///invite
  Future<inviteModel> invite(String email) async {
    try {
      final response = await apiService.post("/register",
          {"email": email, "reciverRole": "teamleader", "companyId": "1"});
      if (response is ApiError) {
        throw response;
      } else if (response == 200) {
        final user = inviteModel.fromJson(response);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: "un expected error from server");
      }
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }



  ///setup company
  Future<setupModel> setup({
    required String name,
    required String industry,
    required String country,
    required String size,
    required String website,
  }) async {
    try {
      final response = await apiServiceSetup.post("/create", {
        "name": name,
        "industry": industry,
        "country": country,
        "size": size,
        "code": website,
        "subscriptionId": ""
      });
      print("this is response : $response");
      if (response is ApiError) {
        throw response;
      }

      if (response is List) {
        if (response.isNotEmpty) {
          final lastAdded = response.last;
          return setupModel.fromJson(lastAdded);
        } else {
          throw ApiError(message: "Success but no data returned");
        }
      }

      // في حال كان الرد Map مباشر
      if (response is Map<String, dynamic>) {
        return setupModel.fromJson(response);
      }

      throw ApiError(message: "Unexpected response format: ${response.runtimeType}");

    } on DioException catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      print("Error in setup repo: $e");
      throw ApiError(message: e.toString());
    }
  }
  ///update description
  /// UPDATE + REFRESH
  Future<setupModel> updateCompanyAndRefresh(
    String name, String industry, String country, String size, String website, String description, String id,
  ) async {
    try {
      /// 1️⃣ UPDATE
      final updateResponse = await apiServiceSetup.put(
        "/Update/$id",
        {
          "name": name, "industry": industry, "country": country, "size": size, "code": website, "description": description, "subscriptionId": ""
        },
      );

      if (updateResponse is ApiError) throw updateResponse;

      final setup = setupModel.fromJson(updateResponse);
      print("✅ COMPANY UPDATED");
print(updateResponse);
      /// 2️⃣ REFRESH TOKEN (بالكوكي)
      final refreshResponse =
      await _apiService.get("/refresh-token");

      if (refreshResponse is ApiError) throw refreshResponse;

      final newToken = refreshResponse["token"];

      if (newToken != null && newToken.isNotEmpty) {
        await PrefHelper.saveToken(newToken);
        print("✅ TOKEN REFRESHED AFTER UPDATE");
      }

      return setup;
    } catch (e) {
      rethrow;
    }
  }
  ///get Company
  ///get Company
  Future<setupModel> getSetup() async {
    try {
      final response = await apiServiceSetup.get("/GetByAdminId");

      print("RESPONSE: $response");
      print("RESPONSE TYPE: ${response.runtimeType}");

      if (response is ApiError) {
        throw response;
      }

      // 1. لو الرد قائمة (List) كما يظهر في الـ Logs عندك
      if (response is List) {
        if (response.isEmpty) {
          throw ApiError(message: "No companies found");
        }
        // نأخذ أول شركة في القائمة (أو آخر شركة حسب ترتيب الـ API)
        // الـ Logs بتقول إن عندك شركتين، غالباً هتحتاج آخر واحدة
        final lastCompany = response.last;
        return setupModel.fromJson(lastCompany);
      }

      // 2. لو الرد Map جاهز
      if (response is Map<String, dynamic>) {
        return setupModel.fromJson(response);
      }

      throw ApiError(message: "Unexpected response format");

    } on DioError catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      print("CATCH ERROR: $e");
      throw ApiError(message: e.toString());
    }
  }


  ///post DB
  Future<List<DBModel>> postDB(String name,String server,String dbName,String user,String password,String dbType)async{
    try{
      final response = await apiServiceDB.post("/api/DbSetting/create",
      {
        "name": name,
        "server": server,
        "dbName": dbName,
        "user": user,
        "password": password,
        "DbType": dbType,
      }
      );
      print("RESPONSE: $response");
      print("RESPONSE TYPE: ${response.runtimeType}");
      if(response is ApiError){
        throw response;
      }
      return [DBModel.fromJson(response)];
    }on DioError catch (e) {
      print("DIO ERROR:");
      print("Status Code: ${e.response?.statusCode}");
      print("Status Message: ${e.response?.statusMessage}");
      print("Response Data: ${e.response?.data}");
      print("Dio Message: ${e.message}");
      throw ApiException.handleError(e);
    } catch (e) {
      print("CATCH ERROR:");
      print("Error: $e");
      throw ApiError(message: e.toString());
    }
  }
}