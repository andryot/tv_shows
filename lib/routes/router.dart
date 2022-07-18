import 'package:flutter/material.dart';

import '../screens/splash.dart';
import 'routes.dart';

abstract class TVSRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TVSRoutes.splash:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SplashScreen(),
        );
    }

    return null;
  }
}
