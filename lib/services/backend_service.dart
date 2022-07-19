import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';

import '../config/config.dart';
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

    _instance = BackendService._(dio: dio);
    //dio.interceptors.add(LogInterceptor());
    return _instance!;
  }

  final Dio _dio;

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

      final Response response = await _dio.postUri(
        uri,
        data: {
          BackendServiceJsonKeys.email: email,
          BackendServiceJsonKeys.password: password,
        },
      );
      if (response.statusCode == HttpStatus.created) {
        final Map<String, dynamic> bodyContents = response.data;

        final Map<String, dynamic> combinedData = HashMap();

        combinedData.addAll(bodyContents[BackendServiceJsonKeys.user]);

        // add all required fields from header values
        combinedData[UserJsonKeys.accessToken] =
            response.headers.value(UserJsonKeys.accessToken);
        combinedData[UserJsonKeys.client] =
            response.headers.value(UserJsonKeys.client);
        combinedData[UserJsonKeys.tokenType] =
            response.headers.value(UserJsonKeys.tokenType);
        combinedData[UserJsonKeys.uid] =
            response.headers.value(UserJsonKeys.uid);

        return value(User.fromJson(combinedData));
      } else {
        return error(const Unauthorized());
      }
    } on DioError catch (_) {
      return error(const Unauthorized());
    }
  }
}

abstract class BackendServiceJsonKeys {
  static const String email = 'email';
  static const String password = 'password';
  static const String user = 'user';
}
