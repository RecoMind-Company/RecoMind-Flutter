import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';

class RobotRep{
  final ApiServiceRobot apiServiceRobot = ApiServiceRobot();

  Future<String> requestRobot() async {
    try{
      final response = await apiServiceRobot.get("/dataAssing");
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
    const delayBetweenRetries = Duration(seconds: 30);

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