import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/router/processors/journals_handler.dart';
import 'package:haskell_is_beautiful/app/pipelines/router/processors/page_handler.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class UpdateRouter extends Pipeline {

  static final UpdateRouter instance = UpdateRouter();

  UpdateRouter() : super([
    JournalsHandlerProcessor(),
    PagesHandlerProcessor()
  ]);

  Route<dynamic> generateRoute(RouteSettings settings) {
    final context = PipelineContext(props: { "settings": settings, "route": settings.name, });
    this.runProcessors(context);
    return context.getResult<Route<dynamic>>();
  }
}
