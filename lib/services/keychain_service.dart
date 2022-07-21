import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user.dart';
import '../style/themes.dart';

class KeychainService {
  static KeychainService? _instance;
  static KeychainService get instance => _instance!;

  KeychainService._({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _secureStorage = flutterSecureStorage;

  factory KeychainService({
    required FlutterSecureStorage flutterSecureStorage,
  }) {
    if (_instance != null) {
      throw StateError('LocalStorageService already created');
    }

    _instance = KeychainService._(flutterSecureStorage: flutterSecureStorage);
    return _instance!;
  }
  final FlutterSecureStorage _secureStorage;

  static const String _user = 'user';
  static const String _themeMode = 'themeMode';

  Future<User?> readUser() async {
    final String? encodedUser = await _secureStorage.read(key: _user);

    if (encodedUser == null) return null;

    final User user =
        User.fromJson(jsonDecode(encodedUser) as Map<String, dynamic>);

    return user;
  }

  Future<void> saveUser(User user) async {
    final String encodedUser = jsonEncode(user.toJson());
    await _secureStorage.write(key: _user, value: encodedUser);
  }

  Future<void> removeUser() async {
    await _secureStorage.delete(key: _user);
  }

  Future<AppTheme?> readThemeMode() async {
    final String? themeModeString = await _secureStorage.read(key: _themeMode);

    if (themeModeString == null) return null;

    final AppTheme theme = AppTheme.values.byName(themeModeString);

    return theme;
  }

  Future<void> saveTheme(AppTheme appTheme) async {
    await _secureStorage.write(key: _themeMode, value: appTheme.name);
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
