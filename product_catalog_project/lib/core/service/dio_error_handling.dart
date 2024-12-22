// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorHandling {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void handleError(DioException error) {
    String errorDescription = '';

    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = 'API sunucusuna yapılan istek iptal edildi.';
      case DioExceptionType.connectionTimeout:
        errorDescription = 'API sunucusuna bağlantı zaman aşımına uğradı.';
      case DioExceptionType.receiveTimeout:
        errorDescription = 'API sunucusundan veri alma zaman aşımına uğradı.';
      case DioExceptionType.badResponse:
        errorDescription =
            'Geçersiz durum kodu alındı: ${error.response?.statusCode}';
      case DioExceptionType.sendTimeout:
        errorDescription = 'API sunucusuna veri gönderme zaman aşımına uğradı.';
      case DioExceptionType.badCertificate:
        errorDescription = 'Geçersiz sertifika alındı.';
      case DioExceptionType.connectionError:
        errorDescription =
            'API sunucusuna bağlantı hatası oluştu. İnternet bağlantınızı kontrol edin.';
      case DioExceptionType.unknown:
        errorDescription = 'Bilinmeyen bir hata oluştu.';
    }

    _showError(errorDescription);
  }

  static void _showError(String message) {
    if (messengerKey.currentState != null) {
      messengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } else {}
  }
}
