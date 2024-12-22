// lib/features/splash/view_models/splash_view_model.dart

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, bool>((ref) {
  return SplashViewModel();
});

class SplashViewModel extends StateNotifier<bool> {
  SplashViewModel() : super(false);

  // Timer objesi
  Timer? _timer;

  // 3 saniye sonra yönlendirmeyi başlatan fonksiyon
  void startTimer() {
    // Timer'ı başlatıyoruz
    _timer = Timer(const Duration(seconds: 3), () {
      state = true; // 3 saniye sonra state değişiyor ve yönlendirme yapılacak
    });
  }

  // Yönlendirme için
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
