import 'package:flutter/cupertino.dart';

Widget articleCard() {
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
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkIz7D7GEp-sbbhR89xHVlt8ewveXGMppXq7D18j2cng&s"))),
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
                      "Text TextTextTextTextTextText",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text("2024-04-13T12:30:00Z")
                ]),
          )
        ],
      ),
    ),
  );
}
