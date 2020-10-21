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

    if (widget.url != null) {
      loadFromUrl(widget.url)
          .then((value) => setState(() => this.code = value));
    }
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
    return content.trim();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == null || widget.url.isEmpty) {
      return Center(child: Text("Specified URL is empty."),);
    }

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
