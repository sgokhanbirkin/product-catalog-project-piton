import 'package:dio/dio.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService _authService;

  AuthInterceptor(this._authService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    super.onError(err, handler);
  }
}
