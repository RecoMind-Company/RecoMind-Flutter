import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/data/review_Model.dart';

class reviewRepo{
  ApiServiceDB apiServiceDB = ApiServiceDB();
  Future<List<DBModel>?> getDB() async {
    const int maxRetries = 10;
    const Duration delayBetweenRetries = Duration(seconds: 2);
    int attempt = 0;

    while (attempt < maxRetries) {
      attempt++;
      try {
        final response = await apiServiceDB
            .get("/company/fb140d33-7e96-474d-a06d-ab3a6c65d1a9");

        print("Attempt $attempt - RESPONSE TYPE: ${response.runtimeType}");

        if (response is ApiError) throw response;

        // لو response List
        if (response is List) {
          if (response.isNotEmpty) {
            return response
                .map((e) => DBModel.fromJson(e as Map<String, dynamic>))
                .toList();
          } else {
            print("Data not ready yet, retrying...");
          }
        } else if (response is Map<String, dynamic>) {
          // لو response Map
          return [DBModel.fromJson(response)];
        } else {
          print("Unexpected response type: ${response.runtimeType}");
        }
      } on DioError catch (e) {
        print("DIO ERROR on attempt $attempt:");
        print("Status Code: ${e.response?.statusCode}");
        print("Status Message: ${e.response?.statusMessage}");
        print("Response Data: ${e.response?.data}");
        print("Dio Message: ${e.message}");
      } catch (e) {
        print("CATCH ERROR on attempt $attempt: $e");
      }

      await Future.delayed(delayBetweenRetries);
    }

    throw ApiError(message: "Data not available after $maxRetries attempts");
  }


}