import 'package:flutter/material.dart';
import 'package:tafsir/common/ui/ui_constants.dart';

class GoToAayahNumber extends StatelessWidget {
  final int number;

  const GoToAayahNumber(this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
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
      ),
    );
  }
}
