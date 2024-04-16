import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Modules/business.dart';
import 'package:news_app/Modules/science.dart';
import 'package:news_app/Modules/settings.dart';
import 'package:news_app/Modules/sports.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../network/remote/DioHelper.dart';

class newsCubit  extends Cubit<newsStates>{
  //constructor
  newsCubit() : super(intialSate());
  //create object
  static newsCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [business() , sports() , science() , settings()];
  List<BottomNavigationBarItem> bottomNavigationIcons = [
    BottomNavigationBarItem(icon: Icon(Icons.business_center_outlined ) ,label: "business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball_outlined), label: "sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science_outlined) , label: "science"),
    BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "settings")
  ];
  //change Theme mode
  void changeAppThemeMode(){
    emit(appThemeModeState());
  }
  //change screen
  int currentIndex = 0 ;
  void changeBottomNavigationBarSate(index){
    currentIndex = index;
    getArticles();
    emit(BottomNavigationBarSate());
  }
  // fetching articles
  List<dynamic> businessArticles =[] ;
  List<dynamic> sportsArticles =[];
  List<dynamic> scienceArticles =[];
  //get date based on the current screen
  Future<void> getArticles() async{
    emit(loadingState());
    if(currentIndex == 0){
      getBusinessArticles();
    }else if (currentIndex ==1){
      getSportsArticles();
    }else{
      getScienceArticles();
    }
  }
  Future<void> getBusinessArticles() async{
    emit(loadingState());
      await DioHelper.getData("v2/top-headlines", {"category" : "business" ,"language" : "en", "apiKey" : "22414d9f32d44c549beb760cc9d48f12" ,})
        .then((value)
      { businessArticles = value.data['articles'];
      print(businessArticles[1]['author']);
        emit(businessGetState());
      }).onError((error, stackTrace) {
        print(error.toString());
        emit(businessGetErrorState(error));
      });
  }
  Future<void> getSportsArticles() async{
    // emit(loadingState());
    await DioHelper.getData("v2/top-headlines", {"category" : "sports" ,"language" : "en", "apiKey" : "22414d9f32d44c549beb760cc9d48f12"})
        .then((value)
    { sportsArticles = value.data['articles'];
    print(sportsArticles[1]['author']);
    emit(sportsGetState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(sportsGetErrorState(error));
    });
  }
  Future<void> getScienceArticles() async{
    // emit(loadingState());
    await DioHelper.getData("v2/top-headlines", {"category" : "science" ,"language" : "en", "apiKey" : "22414d9f32d44c549beb760cc9d48f12"})
        .then((value)
    {  scienceArticles = value.data['articles'];
    print(scienceArticles[1]['author']);
    emit(scienceGetState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(scienceGetErrorState(error));
    });
  }

}