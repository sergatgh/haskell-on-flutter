import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class CreateTabWidget extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    final widgets = context.get<List<Widget>>("widgets");
    final wrappedWidgets = widgets
        .map((e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: e,
            ))
        .toList();

    if (context.has<Widget Function(List<Widget>)>("wrapper")) {
      final wrapper = context.get<Widget Function(List<Widget>)>("wrapper");
      context.setResult(wrapper(wrappedWidgets));
    } else {
      context.setResult(ListView(
        children: wrappedWidgets,
      ));
    }
  }
}
