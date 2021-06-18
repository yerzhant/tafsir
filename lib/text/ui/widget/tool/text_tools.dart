import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/text/ui/widget/tool/font_size_tool.dart';
import 'package:tafsir/text/ui/widget/tool/more_text_tool.dart';
import 'package:tafsir/text/ui/widget/tool/theme_tool.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class TextTools extends StatefulWidget {
  final AnimationController animationController;
  const TextTools(this.animationController, {Key? key}) : super(key: key);

  @override
  _TextToolsState createState() => _TextToolsState();
}

class _TextToolsState extends State<TextTools> {
  var _active = _Tools.more;

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
                _buildTool(),
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
      color: state.toolControlsBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              widget.animationController.forward();
            },
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              color: state.listItemSubtitle,
            ),
          ),
          IconButton(
            onPressed: () {
              Modular.to.pop();
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
      ),
    );
  }

  Widget _buildTool() {
    switch (_active) {
      case _Tools.more:
        return const MoreTextTool();
      case _Tools.theme:
        return const ThemeTool();
      case _Tools.fontSize:
        return const FontSizeTool();
      default:
        return Container();
    }
  }
}

enum _Tools { theme, fontSize, more }
