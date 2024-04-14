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
      create: (BuildContext context) => newsCubit(),
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
            floatingActionButton: FloatingActionButton(onPressed: (){
              // DioHelper.getData("v2/top-headlines", {"category" : "business" , "apiKey" : "22414d9f32d44c549beb760cc9d48f12" ,})
              //     .then((value) => print(value.data.toString())).onError((error, stackTrace) => print(error.toString()));
              DioHelper.getData("v2/top-headlines", {"category" : "sports" , "apiKey" : "22414d9f32d44c549beb760cc9d48f12" ,})
                  .then((value) => print(value.data['articles'][1]['source']['name'])).onError((error, stackTrace) => print(error.toString()));
              // DioHelper.getData("v2/top-headlines", {"category" : "science" , "apiKey" : "22414d9f32d44c549beb760cc9d48f12" ,})
              //     .then((value) => print(value.data.toString())).onError((error, stackTrace) => print(error.toString()));
            },
            child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}