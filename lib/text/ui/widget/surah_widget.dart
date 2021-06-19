import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
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

    var text = '$subject\n';

    text += '\n';
    text += _htmlToString(surah.text) ?? '';

    Share.share(text, subject: subject);
  }

  String? _htmlToString(String html) {
    final doc = parse(html);
    return parse(doc.body?.text).documentElement?.text.trim();
  }
}
