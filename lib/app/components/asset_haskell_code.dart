import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/share_button.dart';

class AssetHaskellCode extends StatefulWidget {
  final String file;

  AssetHaskellCode({this.file}) : super(key: ObjectKey(file));

  @override
  _AssetHaskellCodeState createState() => _AssetHaskellCodeState();
}

class _AssetHaskellCodeState extends State<AssetHaskellCode> {
  String code = "";

  @override
  void initState() {
    super.initState();

    loadFromFile(widget.file).then((value) => setState(() => this.code = value));
  }

  Future<String> loadFromFile(String file) async {
    return await rootBundle.loadString(Uri.decodeFull(file));
  }

  @override
  Widget build(BuildContext context) {
    if (code.isEmpty) {
      return Center(child: Container(child: CircularProgressIndicator()));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HaskellCode(code),
        ShareButton(content: code),
      ],
    );
  }
}
