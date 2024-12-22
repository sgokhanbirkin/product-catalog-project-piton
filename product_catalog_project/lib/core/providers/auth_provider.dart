import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/providers/auth_service_provider.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';

enum AuthStatus { authenticated, unauthenticated }

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthStatus.unauthenticated) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await _authService.getToken();
    if (token != null) {
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> login(String token) async {
    await _authService.saveToken(token);
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await _authService.deleteToken();
    state = AuthStatus.unauthenticated;
  }
}
