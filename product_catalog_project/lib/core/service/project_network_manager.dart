import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/service/dio_error_handling.dart';

@singleton
class ProjectNetworkManager {
  ProjectNetworkManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'AnalyticsToken': '068946dc-cea6-4d9e-9881-bd97e89e771b'},
        connectTimeout: const Duration(seconds: 90),
        receiveTimeout: const Duration(seconds: 90),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          DioErrorHandling.handleError(error);
          return handler.next(error);
        },
      ),
    );
  }
  late final Dio dio;

  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<void> addBaseHeader([String? token]) async {
    if (token != null && token.isNotEmpty) {
      dio.options.headers['authorization'] = token;
    } else {
      dio.options.headers.remove('authorization');
    }
  }

  void changeLocale(String locale) {
    dio.options.headers['locale'] = locale;
  }
}
