part of 'login_bloc.dart';

@immutable
class LoginState {
  final bool isLoading;
  final Failure? failure;

  final bool isPasswordToggled;

  final bool isButtonEnabled;

  const LoginState({
    required this.isLoading,
    required this.failure,
    required this.isPasswordToggled,
    required this.isButtonEnabled,
  });

  const LoginState.initial()
      : isLoading = false,
        failure = null,
        isPasswordToggled = true,
        isButtonEnabled = false;

  LoginState copyWith({
    bool? isLoading,
    Failure? failure,
    bool? isPasswordToggled,
    bool? isButtonEnabled,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      isPasswordToggled: isPasswordToggled ?? this.isPasswordToggled,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}
