import 'package:flutter/material.dart';
import 'package:html/parser.dart';

extension StringExt on String {
  void asSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(this)));
  }

  String parseHtml() {
    final doc = parse(this);
    return parse(doc.body?.text).documentElement?.text.trim() ?? '???';
  }
}
