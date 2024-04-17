import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      builder: (context, state) {
        var cubit = newsCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: false,
                    onChanged: (value) {
                      if(value.isNotEmpty) {
                          cubit.isSearchFieldEmpty = false;
                          cubit.getSearchArticles(onChangeValue: value);
                        }
                      },
                    maxLines: 1,
                    decoration: InputDecoration(
                      label: Text("Search"),
                      prefixIcon: Icon(CupertinoIcons.search),
                    ),
                  ),
                 Expanded(child: Center(child: articlesScreenBuilder(context: context , list: cubit.searchArticles , emptySearchField: cubit.isSearchFieldEmpty)))
                ]
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
