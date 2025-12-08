import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/core/utils/pref_helper.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/data/signup_model.dart';

import '../../../../../core/network/api_exceptions.dart';

class SetupRepository {
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
    required String adminId,
    required String name,
    required String industry,
    required String country,
    required String size,
    required String website,
  }) async {
    try {
      final response = await apiServiceSetup.post("/create", {
        "adminId": adminId,
        "name": name,
        "industry": industry,
        "country": country,
        "size": size,
        "code": website,
        "description": "",
        "subscriptionId": "your-subscription-id-here",
      });

      print("RESPONSE DATA: $response");
      print("RESPONSE TYPE: ${response.runtimeType}");

      if (response is ApiError) {
        throw response;
      }

      final model = setupModel.fromJson(response);
      print("repo success");
      return model;

    } on DioError catch (e) {
      print("---- DIO ERROR ----");

      print("Type: ${e.type}");
      print("Status Code: ${e.response?.statusCode}");
      print("Status Message: ${e.response?.statusMessage}");
      print("Response Data: ${e.response?.data}");
      print("Headers: ${e.response?.headers.map}");
      print("Request Path: ${e.requestOptions.path}");
      print("Request Data: ${e.requestOptions.data}");
      print("Dio Message: ${e.message}");

      print("-------------------");

      throw ApiException.handleError(e);

    } catch (e) {
      print("---- UNKNOWN ERROR ----");
      print(e);
      print("------------------------");
      throw ApiError(message: e.toString());
    }
  }



  ///update description
  Future<setupModel> description(String name, String industry, String country, String size, String website,String description,String AdminId) async {
    try {
      final response = await apiServiceSetup.put(
        "/759e29ff-89f0-45da-8e9b-bd59bea571cb",
        {
          "adminId":AdminId,
          "name": name,
          "industry": industry,
          "country": country,
          "size": size,
          "code": website,
          "description": description
        },
      );
      print("RESPONSE: $response");
      print("RESPONSE TYPE: ${response.runtimeType}");


      if (response is ApiError) {
        throw response;
      }

      final user = setupModel.fromJson(
        response is Map ? response : response.data,
      );

      return user;
    }  on DioError catch (e) {
      print("DIO ERROR:");
      print("Status Code: ${e.response?.statusCode}");
      print("Status Message: ${e.response?.statusMessage}");
      print("Response Data: ${e.response?.data}");
      print("Dio Message: ${e.message}");
      print("Internal Error: ${e.error}");

      throw ApiException.handleError(e);
    } catch (e) {
      print("CATCH ERROR:");
      print("Error: $e");
      throw ApiError(message: e.toString());
    }
  }




  ///get setup
  Future<setupModel> getSetup()async{
    try{
      final response = await apiServiceSetup.get("/759e29ff-89f0-45da-8e9b-bd59bea571cb");
      print("RESPONSE: $response");
      print("RESPONSE TYPE: ${response.runtimeType}");
      if(response is ApiError){
       throw response;
     }
     final user = setupModel.fromJson(response);
     return user;
    }on DioError catch (e) {
      print("DIO ERROR:");
      print("Status Code: ${e.response?.statusCode}");
      print("Status Message: ${e.response?.statusMessage}");
      print("Response Data: ${e.response?.data}");
      print("Dio Message: ${e.message}");
      print("Internal Error: ${e.error}");

      throw ApiException.handleError(e);
    } catch (e) {
      print("CATCH ERROR:");
      print("Error: $e");
      throw ApiError(message: e.toString());
    }
  }





  ///post DB
  Future<List<DBModel>> postDB(String name,String server,String dbName,String user,String password,String dbType)async{
    try{
      final response = await apiServiceDB.post("/company/fb140d33-7e96-474d-a06d-ab3a6c65d1a9",
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