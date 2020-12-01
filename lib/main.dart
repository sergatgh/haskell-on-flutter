import 'package:flutter/material.dart';

import 'app/pages/journals/home_page.dart';

void main() => runApp(MainWrapper());

// Main wrapper should be stateless.
class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: HomePage());
}
