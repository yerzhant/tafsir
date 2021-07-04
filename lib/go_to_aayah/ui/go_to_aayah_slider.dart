import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/go_to_aayah/bloc/go_to_aayah_bloc.dart';

class GoToAayahSlider extends StatelessWidget {
  const GoToAayahSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: BlocBuilder<GoToAayahBloc, GoToAayahState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return Container(
            width: 38,
            color: state.maybeWhen(
              active: (_, __) => primaryColor,
              semiActive: (_, __) => primaryColor.withAlpha(128),
              orElse: () => Colors.transparent,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                state.maybeWhen(
                  active: (position, _) => _Track(position),
                  semiActive: (position, _) => _Track(position),
                  orElse: () => Container(),
                ),
              ],
            ),
          );
        },
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
