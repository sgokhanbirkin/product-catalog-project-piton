// lib/features/splash/view_models/splash_view_model.dart

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/providers/auth_service_provider.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, bool>((ref) {
  final authService = ref.read(authServiceProvider);
  return SplashViewModel(authService);
});

class SplashViewModel extends StateNotifier<bool> {
  final AuthService _authService;

  SplashViewModel(this._authService) : super(false);

  Timer? _timer;

  // 3 saniye sonra yönlendirmeyi başlatan fonksiyon
  void startTimer() {
    _timer = Timer(const Duration(seconds: 3), () async {
      await checkTokenAndNavigate();
    });
  }

  // Token kontrolü ve yönlendirme için
  Future<void> checkTokenAndNavigate() async {
    final token = await _authService.getToken();
    if (token != null) {
      state = true; // Direkt Home'a yönlendir
    } else {
      state = false; // Login ve Atla butonlarını göster
    }
  }

  void navigateToHome() {
    state = true; // state değişir ve navigasyon başlatılır
  }

  // Skip işlemi
  void skip() {
    _timer?.cancel(); // Timer'ı iptal ediyoruz
    state = false; // Skip olduğunda state değişir
  }

  // Butona tıklama işlemi
  void onButtonPressed() {
    _timer?.cancel(); // Timer'ı iptal ediyoruz
    state = false;
  }
}
