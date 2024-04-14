import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/Layouts/NewsLayout.dart';
import 'package:news_app/shared/cubit/observer.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.dio;
  // https://newsapi.org/v2/top-headlines/sources?category=business&apiKey=22414d9f32d44c549beb760cc9d48f12
  DioHelper.getData("v2/top-headlines", {"category" : "business" , "apiKey" : "22414d9f32d44c549beb760cc9d48f12" ,});
  DioHelper.getData("v2/top-headlines", {"category" : "sports" , "apiKey" : "22414d9f32d44c549beb760cc9d48f12" ,});
  DioHelper.getData("v2/top-headlines", {"category" : "science" , "apiKey" : "22414d9f32d44c549beb760cc9d48f12" ,});
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
        primarySwatch: Colors.orange,
        progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.orange),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(shape:
        RoundedRectangleBorder( // <= Change BeveledRectangleBorder to RoundedRectangularBorder
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ), backgroundColor: Colors.orange),
        applyElevationOverlayColor: false,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
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
