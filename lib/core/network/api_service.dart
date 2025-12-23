
import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/dio_client.dart';
///service auth
class ApiService{
  final DioClient _dioClient = DioClient();

  ///CRUD METHODS
///get
Future<dynamic> get(String endPoint)async{
  try {
   final response = await _dioClient.dio.get(endPoint);
   return response.data;
  } on DioError catch (e) {
    return ApiException.handleError(e);
  }
}



///put||update
  Future<dynamic> put(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
///post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        // cause of image as well
        options: Options(
          contentType: body is FormData
              ? 'multipart/form-data'
              : Headers.jsonContentType,
        ),
      );

      return response.data;

    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.delete(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
}


///service invite
class ApiServiceInvite{
  final DioInvite _dioClient = DioInvite();

  ///CRUD METHODS
  ///get
  Future<dynamic> get(String endPoint)async{
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }



  ///put||update
  Future<dynamic> put(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
  ///post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        // cause of image as well
        options: Options(
          contentType: body is FormData
              ? 'multipart/form-data'
              : Headers.jsonContentType,
        ),
      );

      return response.data;

    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.delete(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
}


///service seutp company
class ApiServiceSetup {
  final Diosetup _dioClient = Diosetup();

  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
      );

      return response.data;

    } on DioError catch (e) {
      throw ApiException.handleError(e);
    }
  }

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    }
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    }
  }

  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    }
  }
}



///service report
class ApiServiceReport{
  final DioReport _dioClient = DioReport();

  ///CRUD METHODS
  ///get
  Future<dynamic> get(String endPoint)async{
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }



  ///put||update
  Future<dynamic> put(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
  ///post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        // cause of image as well
        options: Options(
          contentType: body is FormData
              ? 'multipart/form-data'
              : Headers.jsonContentType,
        ),
      );

      return response.data;

    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.delete(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
}


///service DB
class ApiServiceDB{
  final DioDB _dioClient = DioDB();

  ///CRUD METHODS
  ///get
  Future<dynamic> get(String endPoint)async{
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }



  ///put||update
  Future<dynamic> put(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
  ///post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        // cause of image as well
        options: Options(
          contentType: body is FormData
              ? 'multipart/form-data'
              : Headers.jsonContentType,
        ),
      );

      return response.data;

    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.delete(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
}

///service Robot
class ApiServiceRobot{
  final DioRobot _dioClient = DioRobot();

  ///CRUD METHODS
  ///get
  Future<dynamic> get(String endPoint)async{
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }



  ///put||update
  Future<dynamic> put(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
  ///post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        // cause of image as well
        options: Options(
          contentType: body is FormData
              ? 'multipart/form-data'
              : Headers.jsonContentType,
        ),
      );

      return response.data;

    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.delete(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
}


/// service Team
class ApiServiceTeam{
  final DioTeam _dioClient = DioTeam();

  ///CRUD METHODS
  ///get
  Future<dynamic> get(String endPoint)async{
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }



  ///put||update
  Future<dynamic> put(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
  ///post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        // cause of image as well
        options: Options(
          contentType: body is FormData
              ? 'multipart/form-data'
              : Headers.jsonContentType,
        ),
      );

      return response.data;

    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endPoint)async{
    try {
      final response = await _dioClient.dio.delete(endPoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
}


/// service ChatBot
class ApiServiceChatBot{
  final DioChatBot _dioClient = DioChatBot();

  ///CRUD METHODS
  ///get
  Future<dynamic> get(String endPoint)async{
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }



  ///put||update
  Future<dynamic> put(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
  ///post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        // cause of image as well
        options: Options(
          contentType: body is FormData
              ? 'multipart/form-data'
              : Headers.jsonContentType,
        ),
      );

      return response.data;

    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endPoint,Map<String,dynamic> body)async{
    try {
      final response = await _dioClient.dio.delete(endPoint,data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handleError(e);
    }
  }
}