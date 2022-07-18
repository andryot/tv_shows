import 'package:flutter/material.dart';
import 'package:tv_shows/screens/splash.dart';

void main() {
  runApp(const TVShows());
}

class TVShows extends StatelessWidget {
  const TVShows({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Shows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
