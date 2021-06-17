import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/text/ui/widget/tool/more_text_tool.dart';
import 'package:tafsir/text/ui/widget/tool/theme_tool.dart';

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
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildTool(),
            Container(
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
                          : greyColorLight,
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
                          : greyColorLight,
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
                          : greyColorLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTool() {
    switch (_active) {
      case _Tools.more:
        return const MoreTextTool();
      case _Tools.theme:
        return const ThemeTool();
      default:
        return Container();
    }
  }
}

enum _Tools { theme, fontSize, more }
