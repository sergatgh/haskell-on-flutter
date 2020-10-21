import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content_element/build_content_element.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildElements extends Processor {
  BuildContentElement elementBuilder = BuildContentElement();

  @override
  Object safeExecute(PipelineContext context) {
    final data = context.properties["data"] as TabDefinition;
    
    List<Widget> result = []; 
    for (var element in data.content) {
      var newElement = elementBuilder.buildElement(element);
      result.add(newElement);
    }
    context.properties["result"] = result;

    return null;
  }
}