import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: _tokenKey);
    return token;
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
