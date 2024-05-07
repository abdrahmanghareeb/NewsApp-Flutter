import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/Main_Cubit/cubit.dart';
import '../shared/cubit/Main_Cubit/states.dart';

class science extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<News_Cubit, News_State>(
      builder: (context, state) {
        var cubit = News_Cubit.get(context);
        return articlesScreenBuilder(context: context , list: cubit.scienceArticles ,emptySearchField: false);
      },
      listener: (context, state) {},
    );
  }
}
