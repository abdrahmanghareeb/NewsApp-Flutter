import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {

   static late  SharedPreferences prefs ;

   static  init()  async {
     prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setDarkKeyBool({required String key , required bool value}) async{
    return await prefs.setBool(key, value);
  }

  static bool? getDarkKeyBool({required String key}) {
     return  prefs.getBool(key);
   }

}