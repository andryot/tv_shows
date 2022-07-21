import 'dart:convert';

import 'package:flutter_keychain/flutter_keychain.dart';

import '../model/user.dart';
import '../style/themes.dart';

class KeychainService {
  static KeychainService? _instance;
  static KeychainService get instance => _instance!;

  KeychainService._();

  factory KeychainService() {
    if (_instance != null) {
      throw StateError('LocalStorageService already created');
    }

    _instance = KeychainService._();
    return _instance!;
  }

  static const String _user = 'user';
  static const String _themeMode = 'themeMode';

  Future<User?> readUser() async {
    final String? encodedUser = await FlutterKeychain.get(key: _user);

    if (encodedUser == null) return null;

    final User user =
        User.fromJson(jsonDecode(encodedUser) as Map<String, dynamic>);

    return user;
  }

  Future<void> saveUser(User user) async {
    final String encodedUser = jsonEncode(user.toJson());
    await FlutterKeychain.put(key: _user, value: encodedUser);
  }

  Future<void> removeUser() async {
    await FlutterKeychain.remove(key: _user);
  }

  Future<AppTheme?> readThemeMode() async {
    final String? themeModeString = await FlutterKeychain.get(key: _themeMode);

    if (themeModeString == null) return null;

    final AppTheme theme = AppTheme.values.byName(themeModeString);

    return theme;
  }

  Future<void> saveTheme(AppTheme appTheme) async {
    await FlutterKeychain.put(key: _themeMode, value: appTheme.name);
  }

  Future<void> clear() async {
    await FlutterKeychain.clear();
  }

  Future<void> clearKeychain() async {
    await FlutterKeychain.clear();
  }
}
