// lib/core/routes/app_router.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/features/category/views/category_products_view.dart';
import 'package:product_catalog_project/features/home/views/home_view.dart';
// Sayfalarınızın import'ları
import 'package:product_catalog_project/features/login/views/login_view.dart';
import 'package:product_catalog_project/features/product/views/product_detail_view.dart';
import 'package:product_catalog_project/features/register/views/register_view.dart';
import 'package:product_catalog_project/features/splash/views/splash_view.dart';

part 'app_router.gr.dart'; // Build Runner tarafından oluşturulan dosya

@singleton
@AutoRouterConfig(replaceInRouteName: 'View|Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true, // Uygulama ilk açıldığında Splash ekranı gösterilir
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(
          page: ProductDetailRoute.page,
        ),
        AutoRoute(
          page: CategoryProductsRoute.page,
        ),
      ];
}
