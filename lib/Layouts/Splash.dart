import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/Layouts/FingerPrintScreen.dart';
import 'package:news_app/shared/constants/constants.dart';
import '../Shared/Components/components.dart';
import 'Login.dart';
import 'NewsLayout.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future delay(context) async {
    await Future.delayed(Duration(milliseconds: 100));
  }

  @override
  void initState() {
    super.initState();
    delay(context).then((value) {
      if (FirebaseAuth.instance.currentUser == null) {
        navigateReplacementTo(context: context, widget: Login());
      } else {
        if (Fingerprint_bool)
          navigateReplacementTo(context: context, widget: FingerprintScreen());
        else
          navigateReplacementTo(context: context, widget: newsHomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(width: 300 ,height: 300,"assets/splash.png" ,fit: BoxFit.fill,),
          ],
        ),
      ),
    );
  }
}