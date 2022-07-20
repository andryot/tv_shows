import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/global/global_bloc.dart';
import 'routes/router.dart';
import 'routes/routes.dart';
import 'services/backend_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Dio dio = Dio();

  BackendService(dio: dio);
  runApp(const TVShows());
}

class TVShows extends StatelessWidget {
  const TVShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalBloc(),
      child: MaterialApp(
        title: 'TV Shows',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: TVSRouter.onGenerateRoute,
        initialRoute: TVSRoutes.splash,
      ),
    );
  }
}
