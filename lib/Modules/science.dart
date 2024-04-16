import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class science extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      builder: (context, state) {
        var cubit = newsCubit.get(context);
        return articlesScreenBuilder(context: context , list: cubit.scienceArticles);
      },
      listener: (context, state) {},
    );
  }
}
