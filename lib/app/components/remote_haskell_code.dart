import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/share_button.dart';

class RemoteHaskellCode extends StatefulWidget {
  final String url;

  RemoteHaskellCode({this.url}) : super(key: ObjectKey(url));

  @override
  _RemoteHaskellCodeState createState() => _RemoteHaskellCodeState();
}

class _RemoteHaskellCodeState extends State<RemoteHaskellCode> {
  String code = "";

  @override
  void initState() {
    super.initState();

    loadFromUrl(widget.url).then((value) => setState(() => this.code = value));
  }

  Future<String> loadFromUrl(String url) async {
    var content = "";
    await Future.wait([
      new HttpClient()
          .getUrl(Uri.parse(url))
          .then((HttpClientRequest request) => request.close())
          .then((HttpClientResponse response) =>
              response.transform(new Utf8Decoder()).listen((data) {
                content = data;
              }).asFuture())
    ]);
    return content;
  }

  @override
  Widget build(BuildContext context) {
    if (code.isEmpty) {
      return Center(child: Container(child: CircularProgressIndicator()));
    }

    return Column(
      children: [
        HaskellCode(code),
        ShareButton(content: code),
      ],
    );
  }
}
