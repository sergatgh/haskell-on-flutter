import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';

import 'cards/cards_container.dart';
import 'info/info.dart';

class Body extends StatelessWidget {
  final Function(int) onPageChanged;
  final List<JournalViewModel> journals;

  const Body({Key key, this.onPageChanged, this.journals = const[]}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 4,
          child: this.buildTopInformation(),
        ),
        Flexible(
          flex: 8,
          child: this.buildCards(),
        ),
        Spacer()
      ],
    );
  }

  Widget buildTopInformation() {
    return Information();
  }

  Widget buildCards() {
    return CardsContainer(
      onPageChanged: this.onPageChanged,
      journals: this.journals,
    );
  }
}
