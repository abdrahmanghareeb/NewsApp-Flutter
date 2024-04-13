import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Modules/business.dart';
import 'package:news_app/Modules/science.dart';
import 'package:news_app/Modules/settings.dart';
import 'package:news_app/Modules/sports.dart';
import 'package:news_app/shared/cubit/states.dart';

class newsCubit  extends Cubit<newsStates>{
  
  newsCubit() : super(intialSate());
  
  static newsCubit get(context) => BlocProvider.of(context);


  List<Widget> screens = [business() , sports() , science() , settings()];

  List<BottomNavigationBarItem> bottomNavigationIcons = [
    BottomNavigationBarItem(icon: Icon(Icons.business_center_outlined ) ,label: "business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball_outlined), label: "sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science_outlined) , label: "science"),
    BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "settings")
  ];

  int currentIndex = 0 ;

  void changeBottomNavigationBarSate(index){
    currentIndex = index;
    emit(BottomNavigationBarSate());
  }
  
}