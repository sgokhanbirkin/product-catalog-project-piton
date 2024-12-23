import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/service/auth_interceptor.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';
import 'package:product_catalog_project/core/service/logging_interceptor.dart';

var BASE_URL = dotenv.env['BASE_URL'] as String;

@singleton
class ProjectNetworkManager {
  final Dio dio;
  final AuthService _authService;
  final LoggingInterceptor _loggingInterceptor;

  ProjectNetworkManager(
    this._authService,
    this._loggingInterceptor,
  ) : dio = Dio(
          BaseOptions(
            baseUrl: BASE_URL,
            connectTimeout: const Duration(seconds: 50),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(AuthInterceptor(_authService));
    dio.interceptors.add(_loggingInterceptor);
  }

  // POST request method example
  Future<Response> postData({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
