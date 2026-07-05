import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:recomind/core/utils/pref_helper.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

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

    cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(
        "${Directory.systemTemp.path}/cookies",
      ),
    );

    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
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

    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        responseBody: true,
      ),
    );
  }

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

class DioInvite {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.recomind.site',
        headers: {}
    ),
  );

  DioInvite() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class Diosetup {
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
          final token =await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer ${token.trim()}';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class DioReport {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site/",
      responseType: ResponseType.json,
    ),
  );

  DioReport() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class DioDB {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site",
      responseType: ResponseType.json,
    ),
  );

  DioDB() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class DioRobot {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site/api/Report",
      responseType: ResponseType.json,
    ),
  );

  DioRobot() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class DioTeam {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site/api",
      headers:{"Content-Type": "application/json"},
      responseType: ResponseType.json,
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  DioTeam() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class DioChatBot {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.recomind.site/api/Chatbot",
      responseType: ResponseType.json,
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  DioChatBot() {
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          final token =await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

class public {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.recomind.site',
        headers: {
          "accept":  "text/plain",
          "Content-Type": "application/json"
        }
    ),
  );

  public() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer ${token.trim()}';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}