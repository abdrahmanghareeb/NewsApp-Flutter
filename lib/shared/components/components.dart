import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget articleCard({@required image,@required title,@required date,}) {
  return Padding(
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
                    fit: BoxFit.cover,
                    image:
                    NetworkImage(
                        "$image"))),
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
                    ),
                  ),
                  Text("$date")
                ]),
          )
        ],
      ),
    ),
  );
}

Widget articlesScreenBuilder({@required list}){
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder:(context) => ListView.separated(
      physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => articleCard(image: list[index]['urlToImage'],
            title: list[index]['title'] , date : list[index]['publishedAt']
        ),
        separatorBuilder: (context, index) => Padding(
          padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.blueGrey,
          ),
        ),
        itemCount: list.length),
    fallback: (context) => Center(child: CircularProgressIndicator()),
  );
}
