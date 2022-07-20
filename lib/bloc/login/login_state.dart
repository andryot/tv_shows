part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final bool isLoading;
  final Failure? failure;

  final bool isPasswordToggled;

  final bool isButtonEnabled;

  final User? user;
  final double turns;

  const LoginState({
    required this.isLoading,
    this.failure,
    required this.isPasswordToggled,
    required this.isButtonEnabled,
    this.turns = 0.0,
    this.user,
  });

  const LoginState.initial()
      : isLoading = false,
        failure = null,
        isPasswordToggled = true,
        isButtonEnabled = false,
        user = null,
        turns = 0.0;

  LoginState copyWith({
    bool? isLoading,
    Failure? failure,
    bool? isPasswordToggled,
    bool? isButtonEnabled,
    User? user,
    double? turns,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      isPasswordToggled: isPasswordToggled ?? this.isPasswordToggled,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      user: user ?? this.user,
      turns: turns ?? this.turns,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        failure,
        isPasswordToggled,
        isButtonEnabled,
        user?.email,
        turns,
      ];
}
