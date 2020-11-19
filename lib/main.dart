import 'package:flutter/material.dart';

import 'app/main_wrapper.dart';
import 'app/pages/journals/home_cards.dart';

void main() => runApp(MainWrapper());

// Main wrapper should be stateless.
class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: HomeCardsWrapper());
}
