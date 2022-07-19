part of 'show_list_bloc.dart';

@immutable
abstract class _ShowListEvent {
  const _ShowListEvent();
}

class _InitializeEvent extends _ShowListEvent {
  const _InitializeEvent();
}

class _ReloadEvent extends _ShowListEvent {
  const _ReloadEvent();
}
