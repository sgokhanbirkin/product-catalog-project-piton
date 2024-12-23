// lib/main.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_catalog_project/core/di/di_config.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/core/service/dio_error_handling.dart';
import 'package:product_catalog_project/product/init/product_localization.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(ProductAdapter());

  // Hive kutularını açma
  await Hive.openBox<Product>('products');
  await Hive.openBox<Product>('favorites');
  await Hive.openBox<Category>('categories');

  configureDependencies(); // DI yapılandırmasını başlatır

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('tr'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: ProductLocalization(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = GetIt.instance<AppRouter>();

    return MaterialApp.router(
      title: tr('app_title'),
      scaffoldMessengerKey: DioErrorHandling.messengerKey,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
