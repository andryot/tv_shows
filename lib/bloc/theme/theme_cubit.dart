import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/keychain_service.dart';
import '../../style/themes.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final KeychainService _keychainService;
  ThemeCubit({required KeychainService keychainService})
      : _keychainService = keychainService,
        super(ThemeMode.light);

  void setTheme(ThemeMode themeMode) async {
    emit(themeMode);
    await saveThemeMode(themeMode);
  }

  void switchTheme() async {
    final ThemeMode newThemeMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newThemeMode);
    await saveThemeMode(newThemeMode);
  }

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final AppTheme appTheme =
        themeMode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;
    await _keychainService.saveTheme(appTheme);
  }
}
