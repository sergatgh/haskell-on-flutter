import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pages/journals/CenterContent.dart';

class HomeInformation extends StatelessWidget {
  const HomeInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenterContent(
            child: Column(
        mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage("https://picsum.photos/300/300"),
          ),
          Container(
            alignment: Alignment.centerLeft,
            //color: Colors.teal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Hello friend",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .apply(color: Colors.white)),
                ),
                Text(
                    "Here you will find Haskell journals.\nYou have 1 journal but you can add them later.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .apply(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
