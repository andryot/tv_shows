part of 'splash_bloc.dart';

@immutable
class SplashState {
  final String? redirectTo;
  final User? user;
  final ThemeMode? themeMode;
  const SplashState({
    this.redirectTo,
    this.user,
    this.themeMode,
  });

  const SplashState.initial()
      : redirectTo = null,
        user = null,
        themeMode = null;

  SplashState copyWith({
    String? redirectTo,
    User? user,
    ThemeMode? themeMode,
  }) {
    return SplashState(
      redirectTo: redirectTo ?? this.redirectTo,
      user: user ?? this.user,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
