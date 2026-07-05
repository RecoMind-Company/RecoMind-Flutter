import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart'; // تأكد من ضبط مسار الـ ApiService الصحيح بمشروعك
import 'profile_model.dart';

class ProfileRepository {
  final ApiServicepublic _apiService = ApiServicepublic();

  Future<UserProfileModel> getUserProfile() async {
    const String endPoint = "/api/users/getProfile";
    final response = await _apiService.get(endPoint);
    if (response is ApiError) {
      throw response;
    }
    if (response is Map<String, dynamic>) {
      return UserProfileModel.fromJson(response);
    }

    throw ApiError(
      message: "Failed to load profile data. Unexpected response format.",
    );
  }

  /// update profile
  Future<bool> updateProfile(UpdateProfileRequest request) async {
    const String endPoint = "/api/users/updateProfile";

    final Map<String, dynamic> formDataMap = {
      "Name": request.name,
      "Email": request.email,
      "Phone": request.phone,
      "JobTitle": request.jobTitle,
    };

    if (request.photo != null) {
      String fileName = request.photo!.path.split('/').last;
      formDataMap["Photo"] = await MultipartFile.fromFile(
        request.photo!.path,
        filename: fileName,
      );
    }

    final FormData formData = FormData.fromMap(formDataMap);

    final response = await _apiService.put(endPoint, formData);

    if (response is ApiError) {
      throw response;
    }

    return true;
  }
}