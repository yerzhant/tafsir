import 'package:flutter/material.dart';

extension StringExt on String {
  void asSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(this)));
  }
}
