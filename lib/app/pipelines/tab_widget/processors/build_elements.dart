import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_element_widget/build_content_element.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildElements extends Processor {
  BuildContentElement elementBuilder = BuildContentElement();

  @override
  void safeExecute(PipelineContext context) {
    final pieces = context.properties["data"] as List<ContentPiece>;
    
    List<Widget> result = []; 
    for (var element in pieces) {
      var newElement = elementBuilder.buildElement(element);
      if (newElement != null) result.add(newElement);
    }
    context.properties["result"] = result;
  }
}