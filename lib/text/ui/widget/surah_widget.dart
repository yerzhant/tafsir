import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

import 'html_text_widget.dart';

class SurahWidget extends StatelessWidget {
  final Surah surah;
  final SettingsState settings;
  final void Function(SurahWidget) toggleMenu;

  const SurahWidget({
    required this.surah,
    required this.settings,
    required this.toggleMenu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleMenu(this),
      child: Column(
        children: <Widget>[
          HtmlTextWidget(
            surah.text,
            fontSize: settings.tafsirFontSize,
          ),
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
