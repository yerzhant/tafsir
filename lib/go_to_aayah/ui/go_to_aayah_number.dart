import 'package:flutter/material.dart';
import 'package:tafsir/common/ui/ui_constants.dart';

class GoToAayahNumber extends StatelessWidget {
  final int number;
  final bool isSemiActive;

  const GoToAayahNumber(this.number, {Key? key, this.isSemiActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: isSemiActive ? primaryColor.withAlpha(128) : primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
