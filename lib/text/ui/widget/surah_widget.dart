import 'package:flutter/material.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

import 'html_text_widget.dart';

class SurahWidget extends StatelessWidget {
  final Surah surah;

  const SurahWidget(this.surah, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        HtmlTextWidget(surah.text),
        const SizedBox(height: 10),
      ],
    );
  }
}
