// lib/features/splash/views/splash_view.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'dart:async';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  void _navigateToNextPage(BuildContext context) {
    // Örneğin, 3 saniye sonra ana sayfaya geçiş yap
    Timer(Duration(seconds: 3), () {
      context.router.replaceAll([HomeRoute()]);
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigateToNextPage(context); // Ekran yüklendiğinde navigasyonu başlat

    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to Product Catalog',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
