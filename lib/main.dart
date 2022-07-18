import 'package:flutter/material.dart';

import 'routes/router.dart';
import 'routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TVShows());
}

class TVShows extends StatelessWidget {
  const TVShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Shows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: TVSRouter.onGenerateRoute,
      initialRoute: TVSRoutes.splash,
    );
  }
}
