import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tv_shows/bloc/login/login_bloc.dart';
import 'package:tv_shows/model/user.dart';
import 'package:tv_shows/services/backend_service.dart';
import 'package:tv_shows/util/failure.dart';

void main() {
  final Dio dio = Dio();
  final BackendService backendService = BackendService(dio: dio);

  group(
    'LoginBloc',
    () {
      blocTest(
        'emits [] when nothing is added',
        build: () => LoginBloc(backendService: backendService),
        expect: () => [],
      );
      blocTest(
        'emits isPasswordToggled = true when togglePassword is called',
        build: () => LoginBloc(backendService: backendService),
        act: (LoginBloc bloc) => bloc.togglePassword(),
        expect: () => [
          const LoginState.initial().copyWith(isPasswordToggled: false),
        ],
      );

      blocTest(
        'try to login when email and password are unvalid',
        build: () => LoginBloc(backendService: backendService),
        act: (LoginBloc bloc) => bloc..login('test', 'password'),
        wait: const Duration(seconds: 2),
        expect: () => [
          const LoginState.initial().copyWith(isLoading: true),
          const LoginState.initial()
              .copyWith(failure: const UnauthorizedFailure()),
        ],
      );
      blocTest(
        'try to login when email and password are valid',
        build: () => LoginBloc(backendService: backendService),
        act: (LoginBloc bloc) => bloc.login('flutter@infinum.com', 'infinum1'),
        wait: const Duration(seconds: 5),
        expect: () => [
          const LoginState.initial().copyWith(isLoading: true),
          const LoginState.initial().copyWith(
            user: User(email: 'flutter@infinum.com'),
          ),
        ],
      );
    },
  );
}
