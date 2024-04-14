import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';

class newsHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => newsCubit()..getArticles(),
      child: BlocConsumer<newsCubit , newsStates>(
        listener: (BuildContext context, newsStates state) {  },
        builder:(context, state) {
          var cubit = newsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                Icon(CupertinoIcons.search),
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
            ),
            // floatingActionButton: FloatingActionButton(onPressed: (){
            //   cubit.getBusinessArticles();
            //   cubit.getSportsArticles();
            //   cubit.getScienceArticles();
            // },
            // child: Icon(Icons.add),
            // ),
          );
        },
      ),
    );
  }
}