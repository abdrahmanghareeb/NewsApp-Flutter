import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Modules/business.dart';
import 'package:news_app/Modules/science.dart';
import 'package:news_app/Modules/settings.dart';
import 'package:news_app/Modules/sports.dart';
import 'package:news_app/shared/cubit/Main_Cubit/states.dart';
import 'package:news_app/shared/network/local/CasheHelper.dart';

import '../../network/remote/DioHelper.dart';

class News_Cubit extends Cubit<News_State> {

  //constructor
  News_Cubit() : super(intialSate());

  //create object
  static News_Cubit get(context) => BlocProvider.of(context);
  List<String> ListCountry = ['Egypt', 'Armenia', 'India', 'China'];
  List<String> listLanguage = ["ar" , "de" ,  "en" , "es" ,"fr" ,"he" , "it" , "nl" , "no",  "pt" ,"ru" , "sv" , "ud" ,"zh"];

  void changeSetDropDownState() {
    emit(SetDropDownState());
  }


  //for the app theme
  bool isDark = false;
  List<Widget> screens = [business(), sports(), science(),  SettingsScreen()];
  List<BottomNavigationBarItem> bottomNavigationIcons = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_outlined), label: "business"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_outlined), label: "sports"),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: "science"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings")
  ];

  //change Theme mode
  void setCasheValue({@required key, @required value}) {
    CasheHelper.setDarkKeyBool(key: key, value: value).then((value) {
      print("$value");
      emit(setCasheState());
    });
  }

  //change Theme mode
  void changeAppThemeMode({ from_cache}) {
    if(from_cache != null){
      isDark = from_cache;
    }else{
      isDark = !isDark;
    }
    setCasheValue(key: "isDark", value:isDark);
    emit(appThemeModeState());
  }

  //change screen
  int currentIndex = 0;
  void changeBottomNavigationBarSate(index) {
    currentIndex = index;
    getArticles();
    emit(BottomNavigationBarSate());
  }

  // fetching articles
  List<dynamic> businessArticles = [];
  List<dynamic> sportsArticles = [];
  List<dynamic> scienceArticles = [];

  //get date based on the current screen
  Future<void> getArticles() async {
    emit(loadingState());
    if (currentIndex == 0) {
      getBusinessArticles();
    } else if (currentIndex == 1) {
      getSportsArticles();
    } else {
      getScienceArticles();
    }
  }

  Future<void> getBusinessArticles() async {
    emit(loadingState());
    await DioHelper.getData("v2/top-headlines", {
      "category": "business",
      "language": "en",
      "apiKey": "22414d9f32d44c549beb760cc9d48f12",
    }).then((value) {
      businessArticles = value.data['articles'];
      print(businessArticles[1]['author']);
      emit(businessGetState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(businessGetErrorState(error));
    });
  }

  Future<void> getSportsArticles() async {
    // emit(loadingState());
    await DioHelper.getData("v2/top-headlines", {
      "category": "sports",
      "language": "en",
      "apiKey": "22414d9f32d44c549beb760cc9d48f12"
    }).then((value) {
      sportsArticles = value.data['articles'];
      print(sportsArticles[1]['author']);
      emit(sportsGetState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(sportsGetErrorState(error));
    });
  }

  Future<void> getScienceArticles() async {
    // emit(loadingState());
    await DioHelper.getData("v2/top-headlines", {
      "category": "science",
      "language": "en",
      "apiKey": "22414d9f32d44c549beb760cc9d48f12"
    }).then((value) {
      scienceArticles = value.data['articles'];
      print(scienceArticles[1]['author']);
      emit(scienceGetState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(scienceGetErrorState(error));
    });
  }

  // search list and state
  List<dynamic> searchArticles = [];
  bool isSearchFieldEmpty = true ;
  Future<void> getSearchArticles({required String onChangeValue}) async {
    emit(loadingState());
    await DioHelper.getData(
        "v2/everything", {
      "q": onChangeValue,
      "apiKey": "22414d9f32d44c549beb760cc9d48f12",
    }).then((value) {
      searchArticles = value.data['articles'];
      emit(searchGetState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(searchGetErrorState(error));
    });
  }

  void changeIconState(){
    emit(IconState());
  }
  void ChangeSetFingerprintState(){
    emit(IconState());
  }
}
