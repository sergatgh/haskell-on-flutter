import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_journals_previews/get_journals.dart';

import '../../providers/background_data_provider.dart';
import '../../providers/card_list_data_provider.dart';
import '../../components/cards/card.dart';
import '../../journal_view.dart';

class CardsContainer extends StatelessWidget {
  const CardsContainer({Key key}) : super(key: key);

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
    return HomeCards();
  }

  Widget buildDateText(BuildContext context) {
    return DateIndicator();
  }
}

class HomeCards extends StatefulWidget {
  const HomeCards({
    Key key,
  }) : super(key: key);

  @override
  _HomeCardsState createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  List<JournalViewModel> taskLists = [];

  @override
  void initState() {
    super.initState();

    GetJournalsPreviews.instance.getContent().then((value) {
      this.setState(() {
        taskLists = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var cards = taskLists
        .map((list) => JournalCard(
              journal: list,
            ))
        .toList();

    var background = BackgroundDataProvider.of(context);
    var onCardChange = background?.changeColor;
    return CardListDataProvider(
      updateCards: () {
        this.setState(() {});
      },
      child: PageView(
        controller: PageController(
          viewportFraction: 0.8,
          initialPage: 0,
        ),
        children: cards,
        onPageChanged: onCardChange,
        physics: BouncingScrollPhysics(),
      ),
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
