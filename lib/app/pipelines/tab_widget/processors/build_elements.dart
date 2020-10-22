import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_element_widget/build_content_element.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildElements extends Processor {
  BuildContentElement elementBuilder = BuildContentElement();

  @override
  Object safeExecute(PipelineContext context) {
    final tab = context.properties["data"] as TabDefinition;
    
    List<Widget> result = []; 
    for (var element in tab.pieces) {
      var newElement = elementBuilder.buildElement(element);
      if (newElement != null) result.add(newElement);
    }
    context.properties["result"] = result;

    return null;
  }
}