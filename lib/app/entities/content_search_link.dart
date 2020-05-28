import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities/content_link.dart';

class ContentSearchLink extends ContentLink {
  final Icon icon;
  final String title;
  final String category;
  final String codeSample;

  ContentSearchLink._internal(this.icon, this.title, this.category, this.codeSample);
  
  factory ContentSearchLink(ContentLink link, String code) {
    return ContentSearchLink._internal(link.icon, link.title, link.category, code);
  }
}