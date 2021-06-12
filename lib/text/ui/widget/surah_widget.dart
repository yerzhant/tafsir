import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

class SurahWidget extends StatelessWidget {
  final Surah surah;

  const SurahWidget(this.surah, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HtmlWidget(surah.text),
      ],
    );
  }
}
