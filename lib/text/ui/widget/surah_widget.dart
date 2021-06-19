import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

import 'html_text_widget.dart';

class SurahWidget extends StatelessWidget {
  final Surah surah;
  final void Function(SurahWidget) toggleMenu;

  const SurahWidget(this.surah, this.toggleMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => toggleMenu(this),
      child: Column(
        children: <Widget>[
          HtmlTextWidget(surah.text, isRightAligned: false),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void share() {
    final subject = surah.title;

    var text = '$subject\n\n';
    text += surah.text.parseHtml();

    Share.share(text, subject: subject);
  }
}
