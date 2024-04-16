import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/Layouts/NewsLayout.dart';
import 'package:news_app/shared/constants/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/observer.dart';
import 'package:news_app/shared/cubit/states.dart';
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
    return BlocProvider(
      create: (context) => newsCubit()..getArticles(),
      child: BlocConsumer<newsCubit , newsStates>(
        listener: (context, state) {},
        builder:(context, state) =>
            MaterialApp(
          title: 'News App',
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light ,
          theme: ThemeData(
            textTheme: TextTheme(bodyLarge:TextStyle(color: Colors.black) ),
            primarySwatch: Colors.orange,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  systemNavigationBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                )
            ),
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
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 20, selectedItemColor: Colors.orange),
            applyElevationOverlayColor: false,
            scaffoldBackgroundColor: Colors.white,
          ),
          darkTheme: ThemeData(
            applyElevationOverlayColor: false,
            primarySwatch: Colors.orange,
            scaffoldBackgroundColor:HexColor("#0A0A0A") ,
            textTheme: TextTheme(bodyLarge:TextStyle(color: Colors.white70) ),
            appBarTheme:  AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white70 ,fontSize: 20),
                actionsIconTheme: IconThemeData(color: Colors.white70),
                backgroundColor: HexColor("#0A0A0A"),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor("#0A0A0A"),
                  systemNavigationBarColor: HexColor("#0A0A0A"),
                  statusBarIconBrightness: Brightness.light,
                )
            ),
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
            bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                unselectedIconTheme: IconThemeData(color: Colors.white70 ),
                unselectedItemColor: Colors.white70,
                backgroundColor: HexColor("#0A0A0A"),
                elevation: 20, selectedItemColor: Colors.orange),
          ),
          home: newsHomePage(),
        ),
      ),
    );
  }
}
