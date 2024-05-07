import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/Main_Cubit/cubit.dart';
import 'package:news_app/shared/cubit/Main_Cubit/states.dart';

class business extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<News_Cubit, News_State>(
      builder: (context, state) {
        var cubit = News_Cubit.get(context);
        return articlesScreenBuilder(context: context , list: cubit.businessArticles  ,emptySearchField: false);
      },
      listener: (context, state) {},
    );
  }
}
