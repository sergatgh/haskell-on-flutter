import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities/test_content.dart';

import 'app/main_wrapper.dart';

void main() => runApp(HaskellPocketBookApp(TestContent.getTestContent()));
