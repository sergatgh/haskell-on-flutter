import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class WrapTab extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    var result = context.properties["result"] as List;
    context.properties["result"] = [ListView(
      children: result.cast<Widget>().toList(),
      padding: EdgeInsets.all(16.0),
    )];
    return null;
  }
}
