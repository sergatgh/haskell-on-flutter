import 'dart:convert';
import 'dart:io';

import 'package:haskell_is_beautiful/base/pipelines.dart';

class JustDownload extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var url = context.get<String>("url");
    var content = "";
    var uri = Uri.tryParse(url);

    if (uri == null) {
      context.addMessage("Link [$url] has an incorrect value.");
    } else if (!uri.hasScheme) {
      context.addMessage("Link [$url] should have a scheme like [https].");
    } else {
      await new HttpClient()
          .getUrl(uri)
          .then((HttpClientRequest request) => request.close())
          .then((HttpClientResponse response) =>
              response.transform(new Utf8Decoder()).listen((data) {
                content += data;
              }).asFuture());
    }
    context.setResult(content.trim());
  }
}
