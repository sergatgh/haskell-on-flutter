import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/providers/JournalDataProvider.dart';
import 'package:icons_helper/icons_helper.dart';

import 'LinearGradientMask.dart';
import 'list_head.dart';

class JournalCard extends StatelessWidget {
  const JournalCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final journal = JournalDataProvider.of(context).journal;
    return Container(
        child: GestureDetector(
      onVerticalDragUpdate: (details) => {
        if (details.delta.dy < -10)
          Navigator.of(context).pushNamed("journal", arguments: {
            'journal': journal
          }).then((value) => { })
      },
      onTap: () => {
        Navigator.of(context).pushNamed("journal", arguments: {
          'journal': journal
        }).then((value) => { })
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 3,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            child: CircleAvatar(
                              child: LinearGradientMask(
                                child: Icon(
                                  getFontAwesomeIcon(name: journal.icon),
                                  size: 30,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  Color.fromARGB(255, 249, 167, 84),
                            ),
                            width: 48.0,
                            height: 48.0,
                            padding: const EdgeInsets.all(0.1), // borde width
                            decoration: BoxDecoration(
                              color: Colors.black, // border color
                              shape: BoxShape.circle,
                            )),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  )),
              Spacer(
                flex: 4,
              ),
              Flexible(
                  flex: 5,
                  child: ListHead()),
            ],
          ),
        ),
      ),
    ));
  }
}
