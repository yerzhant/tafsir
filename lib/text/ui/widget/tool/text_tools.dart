import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/text/ui/widget/tool/font_size_tool.dart';
import 'package:tafsir/text/ui/widget/tool/more_text_tool.dart';
import 'package:tafsir/text/ui/widget/tool/theme_tool.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class TextTools extends StatefulWidget {
  const TextTools({Key? key}) : super(key: key);

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
                _controls(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _controls(BuildContext context) {
    return Container(
      height: 54,
      color: const Color(0x7fe5e5e5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/close.svg'),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/home.svg'),
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
                  : null,
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
                  : null,
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
                  : null,
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
