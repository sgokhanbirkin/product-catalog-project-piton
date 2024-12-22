// lib/core/service/logging_interceptor.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/service/logger_service.dart';

@singleton
class LoggingInterceptor extends Interceptor {
  final LoggerService _loggerService;

  LoggingInterceptor(this._loggerService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _loggerService.logger.i(
        'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}');
    _loggerService.logger.d('Headers: ${options.headers}');
    _loggerService.logger.d('Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _loggerService.logger.i(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    _loggerService.logger.d('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _loggerService.logger.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl}${err.requestOptions.path}');
    _loggerService.logger.e('Message: ${err.message}');
    if (err.response != null) {
      _loggerService.logger.e('Data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
