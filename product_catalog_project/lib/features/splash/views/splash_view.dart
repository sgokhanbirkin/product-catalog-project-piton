// lib/features/splash/views/splash_view.dart

import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/splash/view_models/splash_view_model.dart';
import 'package:product_catalog_project/product/widgets/custom_elevated_button.dart';

part '../widgets/splash_logo.dart';
part '../widgets/skip_next_button.dart';

@RoutePage()
class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNavigated = ref.watch(splashViewModelProvider);

    const assetName = 'asset/images/logo.svg';

    if (isNavigated) {
      context.router.replace(
        const LoginRoute(),
      );
    } else {
      // Timer'ı başlat
      ref.read(splashViewModelProvider.notifier).startTimer();
    }

    return Scaffold(
      backgroundColor: const Color(0xff1d1d4e),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: context.height * 0.35),
            // Logo
            const _SplashLogo(assetName: assetName),
            // Buton ve Skip metni arasında uygun boşluk
            SizedBox(height: context.height * 0.33),
            // Login Butonu
            CustomElevatedButton(
              buttonText: 'splash.login'.tr(),
              onPressed: () {
                // Butona tıklanınca timer'ı iptal et ve yönlendir
                ref.read(splashViewModelProvider.notifier).onButtonPressed();
                context.router.replace(
                  const LoginRoute(),
                );
              },
            ),

            // Skip Metni
            _SkipTextButton(context: context, ref: ref),
          ],
        ),
      ),
    );
  }
}
