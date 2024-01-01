import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/text/ui/widget/tool/choose_aayaat_font.dart';
import 'package:tafsir/text/ui/widget/tool/font_size_tool.dart';
import 'package:tafsir/text/ui/widget/tool/more_text_tool.dart';
import 'package:tafsir/text/ui/widget/tool/theme_tool.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class TextTools extends StatefulWidget {
  final AnimationController animationController;

  const TextTools(this.animationController, {Key? key}) : super(key: key);

  @override
  State<TextTools> createState() => _TextToolsState();
}

class _TextToolsState extends State<TextTools> {
  var _active = _Tools.more;

  @override
  void initState() {
    super.initState();
    widget.animationController.addStatusListener(_animationStatusListener);
  }

  void _animationStatusListener(status) {
    if (_active == _Tools.fontFamily && status == AnimationStatus.dismissed) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() {
          _active = _Tools.more;
        }),
      );
    }
  }

  @override
  void dispose() {
    widget.animationController.removeStatusListener(_animationStatusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return Container(
            color: state.toolsBackground,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildTool(state),
                ),
                _controls(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _controls(BuildContext context, ThemeState state) {
    return Container(
      height: 54,
      padding: const EdgeInsets.only(right: 17, left: 10),
      color: state.toolControlsBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              widget.animationController.reverse();
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            },
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              color: state.listItemSubtitle,
            ),
          ),
          if (_active != _Tools.fontFamily) ...[
            IconButton(
              onPressed: () {
                Modular.to.popUntil((route) => route.isFirst);
              },
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: state.listItemSubtitle,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _active = _Tools.theme;
                });
              },
              icon: SvgPicture.asset(
                'assets/icons/theme.svg',
                color: _active == _Tools.theme
                    ? Theme.of(context).primaryColor
                    : state.listItemSubtitle,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _active = _Tools.fontSize;
                });
              },
              icon: SvgPicture.asset(
                'assets/icons/font-size.svg',
                color: _active == _Tools.fontSize
                    ? Theme.of(context).primaryColor
                    : state.listItemSubtitle,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _active = _Tools.more;
                });
              },
              icon: SvgPicture.asset(
                'assets/icons/more-horizontal.svg',
                color: _active == _Tools.more
                    ? Theme.of(context).primaryColor
                    : state.listItemSubtitle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTool(ThemeState state) {
    switch (_active) {
      case _Tools.more:
        return MoreTextTool(() => setState(() {
              _active = _Tools.fontFamily;
            }));
      case _Tools.theme:
        return const ThemeTool();
      case _Tools.fontSize:
        return const FontSizeTool();
      case _Tools.fontFamily:
        return ChooseAayaatFont(
          state,
          () => setState(() {
            _active = _Tools.more;
          }),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

enum _Tools { theme, fontSize, fontFamily, more }
