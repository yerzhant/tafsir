import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/ui_constants.dart';

class GoToAayah extends StatelessWidget {
  const GoToAayah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      color: primaryColor,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          _Track(100),
        ],
      ),
    );
  }
}

class _Track extends StatelessWidget {
  final double top;

  const _Track(this.top, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Column(
        children: [
          SvgPicture.asset('assets/icons/go-to-aayah/up.svg'),
          const SizedBox(height: 22),
          SvgPicture.asset('assets/icons/go-to-aayah/rectangle.svg'),
          const SizedBox(height: 22),
          SvgPicture.asset('assets/icons/go-to-aayah/down.svg'),
        ],
      ),
    );
  }
}
