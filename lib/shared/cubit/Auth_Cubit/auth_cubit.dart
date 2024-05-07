
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/Layouts/NewsLayout.dart';

import '../../../Model/UserModel.dart';
import '../../Components/components.dart';
import '../../constants/constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  var user;
  var uid = FirebaseAuth.instance.currentUser?.uid;
  static AuthCubit get(context) => BlocProvider.of(context);
  void changeRegisterState(
      {required email, required password, required username, required phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterSuccessState());
      Create_User(
          photo: user_profile_photo,
          phone: phone,
          email: email,
          name: username,
          uid: value.user?.uid);
      userNameController.text = "";
      emailController.text = "";
      phoneController.text = "";
      passwordController.text = "";
      showToast(msg: "Registering done successfully");
    }).onError((error, stackTrace) {
      showToast(msg: error.toString());
      emit(RegisterErrorState());
    });
  }

  void changeLoginState({required email, required password, usernaem = "" , required context }) {
    emit(LoginLoadingtate());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.phoneNumber);
      print(value.user?.uid);
      emit(LoginSuccessState());
      emailController.text = "";
      passwordController.text = "";
      navigateReplacementTo(context: context, widget: newsHomePage());
      Get_User();
    }).onError((error, stackTrace) {
      showToast(msg: error.toString());
      emit(LoginErrorState());
    });
  }
  void Create_User(
      {required name, required uid, required email, required phone, photo}) {
    emit(CreateUserLoadingState());
    var model = UserModel(
        uid: uid,
        email: AutofillHints.email,
        phone: phone,
        username: name,
        photo: photo);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).onError((error, stackTrace) {
      print("Error is :       ${error.toString()}");
      emit(CreateUserErrorState());
    });
  }
  void Update_User(
      {required uid,
        name,
        email,
        phone,
        photo,
        jobDis,
        jobTitle,
        required context}) {
    emit((UpdateUserLoadingState()));
    var model = UserModel(
        uid: uid,
        email: email,
        job_title: jobTitle,
        job_description: jobDis,
        phone: phone,
        username: name,
        photo: photo);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update(model.toMap())
        .then((value) {
      emit(UpdateUserSuccessState());
      showToast(msg: "Summitted Successfully");
    }).onError((error, stackTrace) {
      print("Error is :       ${error.toString()}");
      emit(UpdateUserErrorState());
    });
  }

  void Get_User() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      emit(GetUserSuccessState());
      user = UserModel.fromJson(value.data());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(GetUserErrorState());
    });
  }
  void changeSignOutState() {
    if (FirebaseAuth.instance.currentUser == null)
      emit(SignOutSuccessState());
    else
      emit(SignOutErrorState());
  }
  void changeIconState() {
    emit(LoginIconState());
  }
}
