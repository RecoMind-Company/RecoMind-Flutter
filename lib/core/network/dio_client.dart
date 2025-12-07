import 'package:dio/dio.dart';
import 'package:recomind/core/utils/pref_helper.dart';

///auth
class DioClient {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.recomind.site/api/Authentication',
        headers: {

        }
    ),
  );

  ///to get token
  DioClient() {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken(); ///from pref helper
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  /// this to get dio
  Dio get dio => _dio;
}

///invite
class DioInvite {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.recomind.site/api/invitation',
        headers: {

        }
    ),
  );

  ///to get token
  DioClient() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken(); ///from pref helper
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  /// this to get dio
  Dio get dio => _dio;
}


///setup company
class Diosetup {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.recomind.site/api/Companies',
        headers: {

        }
    ),
  );

  ///to get token
  DioClient() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken(); ///from pref helper
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  /// this to get dio
  Dio get dio => _dio;
}



/// report
class DioReport {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site/api/Report",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      // لا تضف responseType هنا إذا كنت تريد JSON افتراضياً
      responseType: ResponseType.json, // يمكن وضعه عند الطلب get/post
    ),
  );

  ///to get token
  DioClient() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken(); ///from pref helper
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  /// this to get dio
  Dio get dio => _dio;
}