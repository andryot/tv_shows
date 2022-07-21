import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/global/global_bloc.dart';
import 'bloc/theme/theme_cubit.dart';
import 'routes/router.dart';
import 'routes/routes.dart';
import 'services/backend_service.dart';
import 'services/keychain_service.dart';
import 'style/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Dio dio = Dio();

  BackendService(dio: dio);
  KeychainService();
  runApp(const TVShows());
}

class TVShows extends StatelessWidget {
  const TVShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GlobalBloc(
            keychainService: KeychainService.instance,
          ),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(
            keychainService: KeychainService.instance,
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            title: 'TV Shows',
            darkTheme: TVSThemes.dark,
            theme: TVSThemes.light,
            themeMode: state,
            onGenerateRoute: TVSRouter.onGenerateRoute,
            initialRoute: TVSRoutes.splash,
          );
        },
      ),
    );
  }
}
