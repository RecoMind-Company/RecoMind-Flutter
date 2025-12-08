import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';

class RobotRep{
  final ApiServiceRobot apiServiceRobot = ApiServiceRobot();

  Future<String> requestRobot() async {
    try{
      final response = await apiServiceRobot.post("/dataAssing/fb140d33-7e96-474d-a06d-ab3a6c65d1a9","/");
      if(response != null ){
        print("$response");
        return response;
      } else
        throw ApiError(message: "Something went wrong");
    }on DioError catch(e){
      throw ApiException.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
  }


  Future<String> getRobot(String id) async {
    const delayBetweenRetries = Duration(seconds: 6);

    while (true) {
      try {
        final response = await apiServiceRobot.get("/dataAssignStatus/$id");

        if (response == "SUCCESS") {
          print("✅ Response received:");
          print(response);
          return response;
        } else {
          print("🟡 Response empty, retrying...");
        }

      } on DioError catch (e) {
        print("❌ DioError: ${e.message}, retrying...");
      } catch (e) {
        print("❌ Error: $e, retrying...");
      }

      // 👇 هنا المكان الصحيح
      await Future.delayed(delayBetweenRetries);
    }
  }
}