import 'package:flutter/material.dart';
import 'package:flutter_movies/homepage.dart';
import 'package:flutter_movies/splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(SplashScreen(
    key: UniqueKey(),
    onInitializationCompleted: () {
      runApp(ProviderScope(child: MyApp()));
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies",
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
