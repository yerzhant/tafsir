import 'package:flutter/material.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

import 'html_text_widget.dart';

class SurahWidget extends StatelessWidget {
  final Surah surah;
  final GestureLongPressCallback toggleMenu;

  const SurahWidget(this.surah, this.toggleMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: toggleMenu,
      child: Column(
        children: <Widget>[
          HtmlTextWidget(surah.text, isRightAligned: false),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
