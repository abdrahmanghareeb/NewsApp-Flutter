import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Modules/search.dart';
import 'package:news_app/shared/cubit/Main_Cubit/cubit.dart';
import 'package:news_app/shared/cubit/Main_Cubit/states.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';

import '../shared/constants/constants.dart';

class newsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<News_Cubit, News_State>(
      listener: (BuildContext context, News_State state) {},
      builder: (context, state) {
        var cubit = News_Cubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(
                  icon: Icon(CupertinoIcons.search),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => search(),
                        ));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    cubit.changeAppThemeMode();
                  },
                ),
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
                items: cubit.bottomNavigationIcons));
      },
    );
  }
}
