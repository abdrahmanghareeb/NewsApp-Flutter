import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/Layouts/NewsLayout.dart';
import 'package:news_app/shared/cubit/observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        applyElevationOverlayColor: false,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.orange,
              systemNavigationBarColor: Colors.white,
              statusBarIconBrightness: Brightness.light,
            )),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 20, selectedItemColor: Colors.orange),
      ),
      home: newsHomePage(),
    );
  }
}
