part of 'login_bloc.dart';

@immutable
abstract class _LoginEvent {
  const _LoginEvent();
}

class _TogglePressedEvent extends _LoginEvent {
  const _TogglePressedEvent();
}

class _LoginPressedEvent extends _LoginEvent {
  final String email;
  final String password;
  const _LoginPressedEvent(this.email, this.password);
}

class _EmailOrPasswordChangedEvent extends _LoginEvent {
  const _EmailOrPasswordChangedEvent();
}
