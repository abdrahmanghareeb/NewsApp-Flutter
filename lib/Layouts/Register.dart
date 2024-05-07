import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layouts/Login.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/Main_Cubit/states.dart';

import '../shared/cubit/Auth_Cubit/auth_cubit.dart';
import '../shared/cubit/Main_Cubit/cubit.dart';

class Register extends StatelessWidget {

  bool show = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = News_Cubit.get(context);
          var cubit2 = AuthCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),
                      Text(
                          "create an account....", style :TextStyle(color: Colors.white , fontSize: 40 , fontWeight: FontWeight.bold) ),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: cubit2.emailController,
                          label: "email",
                          TextInputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
                          validator: "email is empty!"),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: cubit2.userNameController,
                          label: "user name",
                          TextInputType: TextInputType.text,
                          prefixIcon: Icons.person,
                          validator: "user name is empty!"),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: cubit2.phoneController,
                          label: "phone",
                          TextInputType: TextInputType.phone,
                          prefixIcon: Icons.phone,
                          validator: "phone is empty!"),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: cubit2.passwordController,
                          TextInputType: TextInputType.visiblePassword,
                          label: "Enter password",
                          onIconTap: () {
                            show = !show;
                            print(show);
                            cubit.changeIconState();
                          },
                          obsecure: show ,
                          prefixIcon: Icons.password_sharp,
                          suffixIcon: show
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          validator: "password is required!!"),
                      SizedBox(height: 30,),

                      appButton(function: (){
                        cubit2.changeRegisterState(email: cubit2.emailController.text, password: cubit2.passwordController.text,
                            username: cubit2.userNameController.text, phone: cubit2.phoneController.text);
                      }, text: "sign up"),
                      SizedBox(height: 30,),

                      clickableText(context: context, function: (){
                        navigateTo(context: context, widget: Login());
                      } ,mainText: "Do you hava an account? " , secText: "sign in")
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
