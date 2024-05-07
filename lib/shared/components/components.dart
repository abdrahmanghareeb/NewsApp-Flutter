import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/Modules/webView.dart';

Widget articleCard(
    {@required image, @required title, @required date, @required url,  @required context}) {
  return InkWell(
    onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => webView(url),));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage("$image"))),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "$title",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      "$date",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ]),
            )
          ],
        ),
      ),
    ),
  );
}

Widget articlesScreenBuilder(
    {@required list, @required context, emptySearchField}) {
  return ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => articleCard(
              context: context,
              image: list[index]['urlToImage'],
              title: list[index]['title'],
              date: list[index]['publishedAt'],
              url: list[index]['url'],
          ),
          separatorBuilder: (context, index) => seperatorBuilder(),
          itemCount: list.length),
      fallback: (context) => !emptySearchField
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(width: 1));
}

Widget seperatorBuilder() {
  return Padding(
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
    child: Container(
      width: double.infinity,
      height: 1,
      color: Colors.blueGrey,
    ),
  );
}
//============================================================


void navigateTo({@required context, @required widget}) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateReplacementTo({@required context, @required widget}) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

Widget defaultFormField(
    {
      height ,
      prefixIcon,
      suffixIcon,
      onIconTap,
      obsecure = false,
      required controller,
      required label,
      validator,
      // color = "#FFFFFF",
      TextInputType = TextInputType.text}) {
  return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: null,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(15), right: Radius.circular(15)),
      ),
      child: TextFormField(
        obscureText: obsecure,
        controller: controller,
        maxLines: 1,
        validator: (value) {
          if (value!.isEmpty) return "$validator";
        },
        keyboardType: TextInputType,
        decoration: InputDecoration(
          // focusColor: HexColor(color),
          // fillColor: HexColor(color),
          // hoverColor: HexColor(color),
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
          GestureDetector(onTap: onIconTap, child: Icon(suffixIcon)),
          label: Text("$label"),
          border: InputBorder.none,
        ),
      ));
}

Widget appButton({required VoidCallback function, required String text}) {
  return MaterialButton(
      minWidth: double.infinity,
      onPressed: function,
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, color: Colors.orangeAccent),
          child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ))));
}

Widget clickableText(
    {required context,
      mainText = "",
      secText = "",
      required GestureTapCallback function}) {
  return GestureDetector(
    onTap: function,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Text(style: Theme.of(context).textTheme.bodyLarge, "$mainText" , overflow: TextOverflow.ellipsis,)),
        Text(
            style: TextStyle(
              color: Colors.orangeAccent,
                fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
            "$secText" , overflow: TextOverflow.ellipsis,),
      ],
    ),
  );
}

Future<bool?> showToast({required msg}){
  return Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

