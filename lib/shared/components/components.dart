import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
