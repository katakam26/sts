// lib/services/secure_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../feature/login/models/login_response.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _tokenTypeKey = 'token_type';
  static const String _isLoggedInKey = 'is_logged_in';

  // Store login response
  Future<void> storeLoginResponse(LoginResponse response) async {
    try {
      await _storage.write(key: _accessTokenKey, value: response.accessToken);
      await _storage.write(key: _refreshTokenKey, value: response.refreshToken);
      await _storage.write(key: _tokenTypeKey, value: response.tokenType);
      await _storage.write(key: _userDataKey, value: json.encode(response.toJson()));
      await _storage.write(key: _isLoggedInKey, value: 'true');
    } catch (e) {
      print('Error storing login response: $e');
      rethrow;
    }
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Get user data
  Future<LoginResponse?> getUserData() async {
    try {
      final userDataString = await _storage.read(key: _userDataKey);
      if (userDataString != null) {
        final Map<String, dynamic> userData = json.decode(userDataString);
        return LoginResponse.fromJson(userData);
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final isLoggedIn = await _storage.read(key: _isLoggedInKey);
      return isLoggedIn == 'true';
    } catch (e) {
      return false;
    }
  }

  // Clear all user data (logout)
  Future<void> clearAll() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _tokenTypeKey);
    await _storage.delete(key: _userDataKey);
    await _storage.delete(key: _isLoggedInKey);
  }
}