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

      } on DioException catch (e) { // 💡 يفضل استخدام DioException في الإصدارات الجديدة من Dio
        print("❌ DioError: ${e.message}");

        // ✅ فحص لو الـ status code من السيرفر هو 500
        if (e.response?.statusCode == 500) {
          print("🛑 Server Error 500 detected. Stopping retries.");
          // تقدر ترمي خطأ عشان الـ UI يعرف:
          throw Exception("Server Error 500: Internal Server Error");
          // أو لو حابب تخرج وترجع قيمة مخصصة بدل الـ throw:
          // return "SERVER_ERROR_500";
        }

        print("🔄 Retrying after connection/other error...");
      } catch (e) {
        print("❌ Error: $e, retrying...");
      }

      await Future.delayed(delayBetweenRetries);
    }
  }
}