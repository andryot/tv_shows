import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';

import '../config/config.dart';
import '../model/show.dart';
import '../model/user.dart';
import '../server/routes.dart';
import '../util/either.dart';
import '../util/failure.dart';

class BackendService {
  static BackendService? _instance;
  static BackendService get instance => _instance!;

  const BackendService._({required Dio dio}) : _dio = dio;

  factory BackendService({required Dio dio}) {
    if (_instance != null) {
      throw StateError('BackendService already created');
    }
    dio.interceptors.add(CustomInterceptor());
    _instance = BackendService._(dio: dio);

    return _instance!;
  }

  final Dio _dio;

  Future<Either<Failure, T>> backendRequest<T, U>({
    required Future<Response<U>> Function() request,
    required T Function(Response<U> response) onSuccess,
    required Failure failure,
    required int httpStatusCode,
  }) async {
    try {
      final Response<U> response = await request();
      if (response.statusCode == httpStatusCode) {
        return value(onSuccess(response));
      } else {
        return error(failure);
      }
    } on DioError catch (_) {
      return error(failure);
    }
  }

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final Uri uri = Uri(
        scheme: Config.backendApiScheme,
        host: Config.backendApiHost,
        pathSegments: [
          ServerRoutes.users,
          ServerRoutes.usersSignIn,
        ],
      );

      return backendRequest(
        request: () => _dio.postUri<void>(
          uri,
          data: {
            BackendServiceJsonKeys.email: email,
            BackendServiceJsonKeys.password: password,
          },
        ),
        onSuccess: (Response<void> response) {
          final Map<String, dynamic> bodyContents =
              response.data as Map<String, dynamic>;

          final Map<String, dynamic> combinedData = HashMap();

          combinedData.addAll(bodyContents[BackendServiceJsonKeys.user]
              as Map<String, dynamic>);

          // add all required fields from header values
          combinedData[UserJsonKeys.accessToken] =
              response.headers.value(UserJsonKeys.accessToken);
          combinedData[UserJsonKeys.client] =
              response.headers.value(UserJsonKeys.client);
          combinedData[UserJsonKeys.tokenType] =
              response.headers.value(UserJsonKeys.tokenType);
          combinedData[UserJsonKeys.uid] =
              response.headers.value(UserJsonKeys.uid);
          combinedData[UserJsonKeys.expiry] =
              response.headers.value(UserJsonKeys.expiry) == null
                  ? null
                  : int.tryParse(response.headers.value(UserJsonKeys.expiry)!);

          return User.fromJson(combinedData);
        },
        failure: const UnauthorizedFailure(),
        httpStatusCode: HttpStatus.created,
      );
    } on DioError catch (_) {
      return error(const UnauthorizedFailure());
    }
  }

  Future<Either<Failure, List<Show>>> getShows({
    required User user,
  }) async {
    try {
      final Uri uri = Uri(
        scheme: Config.backendApiScheme,
        host: Config.backendApiHost,
        pathSegments: [
          ServerRoutes.shows,
        ],
      );
      return backendRequest(
        request: () => _dio.getUri<void>(
          uri,
          options: Options(
            headers: {
              UserJsonKeys.accessToken: user.accessToken,
              UserJsonKeys.client: user.client,
              UserJsonKeys.tokenType: user.tokenType,
              UserJsonKeys.uid: user.uid,
            },
          ),
        ),
        onSuccess: (Response<void> response) {
          final Map<String, dynamic> bodyContents =
              response.data as Map<String, dynamic>;

          final List<Show> shows = (bodyContents[BackendServiceJsonKeys.shows]
                  as List)
              .map<Show>(
                  (dynamic show) => Show.fromJson(show as Map<String, dynamic>))
              .toList();

          return shows;
        },
        failure: const UnauthorizedFailure(),
        httpStatusCode: HttpStatus.ok,
      );
    } on DioError catch (_) {
      return error(const UnauthorizedFailure());
    }
  }
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<void> response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}

abstract class BackendServiceJsonKeys {
  static const String email = 'email';
  static const String password = 'password';

  static const String user = 'user';
  static const String shows = 'shows';
}
