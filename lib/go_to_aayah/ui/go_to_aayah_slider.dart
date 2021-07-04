import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/go_to_aayah/bloc/go_to_aayah_bloc.dart';

const goToAayahSliderWidth = 38.0;

class GoToAayahSlider extends StatelessWidget {
  final double? position;

  const GoToAayahSlider(this.position, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _box(context),
        if (position != null) _Track(position!),
      ],
    );
  }

  GestureDetector _box(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        Modular.get<GoToAayahBloc>().add(GoToAayahEvent.slidedTo(
          details.globalPosition,
          context,
        ));
      },
      onVerticalDragEnd: (details) {
        Modular.get<GoToAayahBloc>().add(const GoToAayahEvent.ended());
      },
      child: Container(
        width: goToAayahSliderWidth,
        color: primaryColor,
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
      top: top - 36,
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
