import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_element_widget/build_content_element.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildElements extends Processor {
  BuildContentElement elementBuilder = BuildContentElement();

  @override
  void safeExecute(PipelineContext context) {
    final pieces = context.get<List<ContentPiece>>("data");

    List<Widget> result = [];
    for (var element in pieces) {
      final newElement = elementBuilder.buildElement(element);
      if (newElement != null) {
        result.add(newElement);
      }
    }
    
    context["widgets"] = result;
  }
}
