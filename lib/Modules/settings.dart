import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/cubit/Main_Cubit/cubit.dart';
import 'package:news_app/shared/cubit/Main_Cubit/states.dart';

import '../../Shared/Components/components.dart';
import '../shared/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  var language_init = "English";
  var country_init = "Egypt";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<News_Cubit, News_State>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = News_Cubit.get(context);
        return  Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Language",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    child: DropdownButton(
                      style: Theme.of(context).textTheme.bodyLarge,
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      isExpanded: true,
                      value: language_init,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      items: cubit.listLanguage
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        cubit.changeSetDropDownState();
                        language_init = value!;
                        print(value);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text("Country",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    // color: HexColor(Grey_color),
                    child: DropdownButton(
                      style: Theme.of(context).textTheme.bodyLarge,
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      isExpanded: true,
                      value: country_init,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      items:
                      cubit.ListCountry.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? value) {
                        cubit.changeSetDropDownState();
                        country_init = value!;
                        print("$value");
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("Fingerprint",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    CupertinoSwitch(
                      value: Fingerprint_bool,
                      onChanged: (value) {
                        Fingerprint_bool = value;
                        print("$value");
                        cubit.ChangeSetFingerprintState();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                appButton(function: () {

                }, text: "Summit"),
              ],
            ),
          ),
        );
      },
    );
  }
}