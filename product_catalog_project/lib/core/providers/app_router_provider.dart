import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
