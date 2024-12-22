import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/routes/auth_guard.dart';

final authGuardProvider = Provider<AuthGuard>((ref) {
  return AuthGuard(ref);
});
