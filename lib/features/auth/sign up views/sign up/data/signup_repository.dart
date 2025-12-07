import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/core/utils/pref_helper.dart';
import 'package:recomind/features/auth/sign%20up%20views/sign%20up/data/signup_model.dart';

import '../../../../../core/network/api_exceptions.dart';

class signUpRepo{
  ApiService apiService = ApiService();


  ///signUp
  Future<AuthResponse> signUp(String name,String email,String password)async{
    try{
      final response = await apiService.post("/register", {
        "fullName":name,
        "email":email,
        "password":password,
        "role": "admin"
      });
      if(response is ApiError){
        throw ApiError(
            message: "try again");
      }else if(response["isAuthenticated"] == true){
        final user = AuthResponse.fromJson(response);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        print("${user.token}");
        return user;}else{
        throw ApiError(message: "un expected error from server");
      }
    }on DioError catch(e) {
      throw ApiException.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
  }

}