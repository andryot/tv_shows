part of 'global_bloc.dart';

@immutable
abstract class _GlobalEvent {
  const _GlobalEvent();
}

class _UpdateUserEvent extends _GlobalEvent {
  final User user;
  const _UpdateUserEvent(this.user);
}
