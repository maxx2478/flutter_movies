import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies/models/app_config.dart';
import 'package:flutter_movies/services/http_service.dart';
import 'package:flutter_movies/services/movie_service.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationCompleted;

  const SplashScreen({Key? key, required this.onInitializationCompleted})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) =>
        _setup(context).then((value) => widget.onInitializationCompleted()));
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString("assets/config/main.json");
    final configData =  jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(AppConfig(configData['BASE_URL'],
        configData['BASE_IMAGE_URL'], configData['API_KEY']));
    
    getIt.registerSingleton<HTTPService>(HTTPService());

    var service = getIt.registerSingleton<MovieService>(MovieService());

    


    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/images/logo.png"))),
        ),
      ),
    );
  }
}
