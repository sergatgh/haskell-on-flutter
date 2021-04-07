import 'package:flutter/material.dart';

import 'cards/cards_container.dart';
import 'info/info.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 4,
          child: Information(),
        ),
        Flexible(
          flex: 8,
          child: CardsContainer(),
        ),
        Spacer()
      ],
    );
  }
}
