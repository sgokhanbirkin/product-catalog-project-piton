// lib/core/service/auth_service.dart

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';

@singleton
class AuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Dio _dio = Dio(); // Dio ile API'ye istek göndereceğiz.
  static const String _tokenKey = 'auth_token';

  // API'ye login isteği atılıyor
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await _dio.post(
        '$BASE_URL/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['action_login']['token'];

        // Token'ı kaydet
        await saveToken(token as String);

        // Eğer "Remember Me" aktifse token'ı kaydedeceğiz
        if (token != null) {
          await saveToken(token);
        }
      } else {
        _showErrorPopup(context, 'login.login_error_fail'.tr());
        throw Exception('login.login_error_fail'.tr());
      }
    } on DioException catch (e) {
      _showErrorPopup(context, 'login.login_error_api'.tr());
      throw Exception('login.login_error_api'.tr());
    } catch (e) {
      _showErrorPopup(context, 'login.login_error_unknown'.tr());
      throw Exception('login.login_error_unknown'.tr());
    }
  }

  // Register işlemi
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await _dio.post(
        '$BASE_URL/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['action_register']['token'];
        print('Token: $token');
        // Token'ı kaydet
        await saveToken(token as String);

        // Eğer "Remember Me" aktifse token'ı kaydedeceğiz
        if (true) {
          // `rememberMe` burada kullanılabilir
          await saveToken(token);
        }
      } else {
        _showErrorPopup(context, 'register.register_error_fail'.tr());
        throw Exception('register.register_error_fail'.tr());
      }
    } on DioException catch (e) {
      _showErrorPopup(context, 'register.register_error_api'.tr());
      throw Exception('register.register_error_api'.tr());
    } catch (e) {
      _showErrorPopup(context, 'register.register_error_unknown'.tr());
      throw Exception('register.register_error_unknown'.tr());
    }
  }

  // Token'ı kaydetme
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  // Token'ı alma
  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: _tokenKey);
    return token;
  }

  // Token'ı silme
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  // Kullanıcıya hata mesajı gösteren pop-up
  void _showErrorPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('login.login_error'.tr()),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('login.login_ok'.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Pop-up'ı kapat
              },
            ),
          ],
        );
      },
    );
  }
}
