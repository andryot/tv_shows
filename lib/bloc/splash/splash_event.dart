part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class _InitializeEvent extends SplashEvent {
  const _InitializeEvent();
}
