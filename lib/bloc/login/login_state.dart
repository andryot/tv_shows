part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final bool isLoading;
  final Failure? failure;

  final bool isPasswordToggled;

  final bool isButtonEnabled;

  final User? user;

  const LoginState(
      {required this.isLoading,
      this.failure,
      required this.isPasswordToggled,
      required this.isButtonEnabled,
      this.user});

  const LoginState.initial()
      : isLoading = false,
        failure = null,
        isPasswordToggled = true,
        isButtonEnabled = false,
        user = null;

  LoginState copyWith({
    bool? isLoading,
    Failure? failure,
    bool? isPasswordToggled,
    bool? isButtonEnabled,
    User? user,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      isPasswordToggled: isPasswordToggled ?? this.isPasswordToggled,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        failure,
        isPasswordToggled,
        isButtonEnabled,
        user?.email,
      ];
}
