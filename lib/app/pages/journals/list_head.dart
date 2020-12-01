import 'package:flutter/material.dart';

import 'task_list_view_model.dart';

class ListHead extends StatelessWidget {
  final JournalViewModel journal;

  const ListHead({
    @required this.journal,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.cyan,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Hero(
            tag: 'tasks-number-' + this.journal.identifier,
            child: buildTitleInformation(context),
          ),
          buildProgressBar()
        ],
      ),
    );
  }

  Row buildProgressBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 3.5,
            child: LinearProgressIndicator(
              value: 22 / 100,
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 249, 167, 84)),
              backgroundColor: Color.fromARGB(255, 247, 247, 247),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 10),
            child: Text("22%"))
      ],
    );
  }

  Container buildTitleInformation(BuildContext context) {
    return Container(
        // color: Colors.blue,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTasksAmountText(),
        buildTitleText(context),
      ],
    ));
  }

  Text buildTitleText(BuildContext context) =>
      Text(this.journal.title,
          style: Theme.of(context).textTheme.headline4);

  Text buildTasksAmountText() {
    return Text(
      "Journal by",    
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w300, letterSpacing: 0.15),
    );
  }
}
