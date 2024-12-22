import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
