// lib/core/service/project_network_manager.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/service/auth_interceptor.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';
import 'package:product_catalog_project/core/service/logging_interceptor.dart';

const BASE_URL = 'https://assign-api.piton.com.tr/api/rest';

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
}
