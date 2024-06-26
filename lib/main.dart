import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/Layouts/Login.dart';
import 'package:news_app/shared/cubit/Auth_Cubit/auth_cubit.dart';
import 'package:news_app/shared/cubit/Main_Cubit/cubit.dart';
import 'package:news_app/shared/cubit/Main_Cubit/states.dart';
import 'package:news_app/shared/cubit/Main_Cubit/observer.dart';
import 'package:news_app/shared/network/local/CasheHelper.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';
import 'Layouts/Register.dart';
import 'Layouts/Splash.dart';

Future<void> main() async {
  //to mage sure every thing is initialized before run App
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.dio;
  await CasheHelper.init();
  bool? isDarkCacheValue = CasheHelper.getDarkKeyBool(key: "isDark");

  if(Platform.isAndroid){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCkdp3wXrBn-UKzVY4-N3W-vBakaOGEtx8",
            appId: "1:3091851703:android:c396b18ef297c05ea96032",
            messagingSenderId: "3091851703",
            projectId: "com.example.hotel_booking"));
  }

  // it is not legal to pass nullable isDarkCacheValue variable to MyApp constructor
  // so Dummy is here with a default value of false
  // false will make the application to in the light mode
  bool Dummy = false;
  // https://newsapi.org/v2/top-headlines/sources?category=business&apiKey=22414d9f32d44c549beb760cc9d48f12
  DioHelper.getData("v2/top-headlines", {
    "category": "business",
    "apiKey": "22414d9f32d44c549beb760cc9d48f12",
  });
  DioHelper.getData("v2/top-headlines", {
    "category": "sports",
    "apiKey": "22414d9f32d44c549beb760cc9d48f12",
  });
  DioHelper.getData("v2/top-headlines", {
    "category": "science",
    "apiKey": "22414d9f32d44c549beb760cc9d48f12",
  });
  if(isDarkCacheValue != null){
    Dummy = isDarkCacheValue;
  }
  runApp( MyApp(Dummy));
}

class MyApp extends StatelessWidget {

  final bool boolValue;

  const MyApp(this.boolValue,{super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => News_Cubit()..getArticles()..changeAppThemeMode(),
),
    BlocProvider(
      create: (context) => AuthCubit(),
    ),
  ],
  child: BlocConsumer<News_Cubit, News_State>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          themeMode: News_Cubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
            primarySwatch: Colors.orange,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  systemNavigationBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                )),
            progressIndicatorTheme:
                ProgressIndicatorThemeData(color: Colors.orange),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                shape: RoundedRectangleBorder(
                  // <= Change BeveledRectangleBorder to RoundedRectangularBorder
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                backgroundColor: Colors.orange),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 20, selectedItemColor: Colors.orange),
            applyElevationOverlayColor: false,
            scaffoldBackgroundColor: Colors.white,
          ),
          darkTheme: ThemeData(
            dropdownMenuTheme: DropdownMenuThemeData(menuStyle: MenuStyle(backgroundColor: MaterialStatePropertyAll(Colors.black54))),
            applyElevationOverlayColor: false,
            primarySwatch: Colors.orange,
            scaffoldBackgroundColor: HexColor("#0A0A0A"),
            textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white70)),
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(color: Colors.white70, fontSize: 20),
                actionsIconTheme: IconThemeData(color: Colors.white70),
                iconTheme: IconThemeData(color: Colors.white70),
                backgroundColor: HexColor("#0A0A0A"),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor("#0A0A0A"),
                  systemNavigationBarColor: HexColor("#0A0A0A"),
                  statusBarIconBrightness: Brightness.light,
                )),
            progressIndicatorTheme:
                ProgressIndicatorThemeData(color: Colors.orange),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                shape: RoundedRectangleBorder(
                  // <= Change BeveledRectangleBorder to RoundedRectangularBorder
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                backgroundColor: Colors.orange),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedIconTheme: IconThemeData(color: Colors.white70),
                unselectedItemColor: Colors.white70,
                backgroundColor: HexColor("#0A0A0A"),
                elevation: 20,
                selectedItemColor: Colors.orange),
          ),
          home: SplashScreen(),
        ),
      ),
);
  }
}
