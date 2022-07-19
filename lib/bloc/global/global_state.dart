part of 'global_bloc.dart';

@immutable
class GlobalState {
  final User? user;

  const GlobalState(
    this.user,
  );

  const GlobalState.initial() : user = null;

  GlobalState copyWith({
    User? user,
  }) =>
      GlobalState(
        user ?? this.user,
      );
}
