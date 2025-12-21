import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recomind/core/utils/pref_helper.dart';

///auth
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:recomind/core/utils/pref_helper.dart';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  late final Dio dio;
  late final PersistCookieJar cookieJar;

  DioClient() {
    final baseOptions = BaseOptions(
      baseUrl: 'https://api.recomind.site/api/Authentication',
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      responseType: ResponseType.json,
    );

    dio = Dio(baseOptions);

    /// 🟢 Persist cookies (مهم جدًا للأندرويد)
    cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(
        "${Directory.systemTemp.path}/cookies",
      ),
    );

    dio.interceptors.add(CookieManager(cookieJar));

    /// 🟡 Authorization interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          /// ❌ refresh-token من غير Authorization
          if (options.path.contains("refresh-token")) {
            return handler.next(options);
          }

          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] =
            'Bearer ${token.trim()}';
          }

          return handler.next(options);
        },
      ),
    );

    /// 🔵 Logger
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        responseBody: true,
      ),
    );
  }

  /// 🧪 للتأكد إن الكوكيز اتحفظت
  Future<void> debugCookies() async {
    final cookies = await cookieJar.loadForRequest(
      Uri.parse('https://api.recomind.site'),
    );

    print('🍪 COOKIES COUNT: ${cookies.length}');
    for (final c in cookies) {
      print('🍪 ${c.name} = ${c.value}');
    }
  }
}
///invite
class DioInvite {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.recomind.site',
        headers: {

        }
    ),
  );

  ///to get token
  DioInvite() {
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
         "accept":  "text/plain",
          "Content-Type": "application/json"
        }
    ),

  );

  Diosetup() {

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken(); ///from pref helper
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer ${token.trim()}';
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
  DioReport() {
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


///DB
class DioDB {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      // لا تضف responseType هنا إذا كنت تريد JSON افتراضياً
      responseType: ResponseType.json, // يمكن وضعه عند الطلب get/post
    ),
  );

  ///to get token
  DioDB() {
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

///Robot
class DioRobot {
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
  DioRobot() {
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


///Team
class DioTeam {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site/api",
        headers:{ "Content-Type": "application/json"},

      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
        ),
  );

  ///to get token
  DioTeam() {
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



///chatbot
class DioChatBot {
  /// this to baseurl
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site/api/Chatbot",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  ///to get token
  DioChatBot() {
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

