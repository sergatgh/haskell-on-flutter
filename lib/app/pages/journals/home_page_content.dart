import 'package:flutter/material.dart';

import 'home_cards.dart';
import 'home_info.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 4,
          child: HomeInformation(),
        ),
        Flexible(
          flex: 8,
          child: HomeCardsWrapper(),
        ),
        Spacer()
      ],
    );
  }
}
