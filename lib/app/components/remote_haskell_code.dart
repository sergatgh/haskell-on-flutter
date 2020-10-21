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
  String error = "";

  @override
  void initState() {
    super.initState();

    if (widget.url != null) {
      loadFromUrl(widget.url)
          .then((value) => setState(() => this.code = value));
    } else {
      error = "Specified URL is empty.";
    }
  }

  Future<String> loadFromUrl(String url) async {
    var content = "";
    var uri = Uri.tryParse(url);

    if (uri == null) {
      error = "Link [$url] has an incorrect value.";
    } 
    else if (!uri.hasScheme) {
      error = "Link [$url] should have a scheme like [https].";
    }
    else {
      await Future.wait([
        new HttpClient()
            .getUrl(uri)
            .then((HttpClientRequest request) => request.close())
            .then((HttpClientResponse response) =>
                response.transform(new Utf8Decoder()).listen((data) {
                  content = data;
                }).asFuture())
      ]);
    }
    return content.trim();
  }

  @override
  Widget build(BuildContext context) {
    if (error.isNotEmpty) {
      return Center(
        child: Text(error),
      );
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
