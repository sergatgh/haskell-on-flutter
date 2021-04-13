import 'package:flutter/material.dart';

import '../../components/cards/card.dart';
import '../../journal_view.dart';

class CardsContainer extends StatelessWidget {
  final Function(int) onPageChanged;
  final List<JournalViewModel> journals;
  const CardsContainer({Key key, this.onPageChanged, this.journals = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.greenAccent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildDateText(context),
          Expanded(
            child: buildCartsList(context),
          ),
        ],
      ),
    );
  }

  Widget buildCartsList(BuildContext context) {
    return Cards(
      onPageChanged: this.onPageChanged,
      pages: journals,
    );
  }

  Widget buildDateText(BuildContext context) {
    return DateIndicator();
  }
}

class Cards extends StatefulWidget {
  final List<JournalViewModel> pages;
  final Function(int) onPageChanged;

  const Cards({
    Key key,
    this.onPageChanged,
    this.pages = const [],
  }) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cards = widget.pages
        .map((list) => JournalCard(
              journal: list,
            ))
        .toList();

    return PageView(
      controller: PageController(
        viewportFraction: 0.8,
        initialPage: 0,
      ),
      children: cards,
      onPageChanged: widget.onPageChanged,
      physics: BouncingScrollPhysics(),
    );
  }
}

class DateIndicator extends StatefulWidget {
  const DateIndicator({
    Key key,
  }) : super(key: key);

  @override
  _DateIndicatorState createState() => _DateIndicatorState();
}

class _DateIndicatorState extends State<DateIndicator> {
  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var tomorrow = today.add(Duration(days: 1));
    Future.delayed(tomorrow.difference(now))
        .then((value) => this.setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var data = "Latest : parse XML";

    return Center(
      child: Container(
        // color: Colors.yellow,
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(data.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .apply(color: Colors.white)),
      ),
    );
  }
}
