import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';

import '../shared/constants/constants.dart';

class newsHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit , newsStates>(
      listener: (BuildContext context, newsStates state) {  },
      builder:(context, state) {
        var cubit = newsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(icon: Icon(CupertinoIcons.search), onPressed: () {  },),
              IconButton(icon: Icon(Icons.brightness_4_outlined), onPressed: () {
                cubit.changeAppThemeMode();
              },),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                print(value);
                cubit.changeBottomNavigationBarSate(value);
              },
              elevation: 50,
              items: cubit.bottomNavigationIcons
          )
        );
      },
    );
  }
}