import 'package:flutter/material.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/ui/html_text.dart';

const _server = 'https://azan.ru';
const _images = '$_server/media/images/surahs';

var _surahTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.grey[800],
);

const _secondaryTextStyle = TextStyle(color: Colors.grey);

class SurahInfo extends StatelessWidget {
  final Surah surah;

  SurahInfo({Key key, this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network('$_images/${surah.image}'),
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (surah.isSurah())
              Text(surah.weight.toString(), style: _surahTitleStyle),
            if (surah.isSurah()) SizedBox(width: 10),
            Text(getTitle(), style: _surahTitleStyle),
          ],
        ),
        if (surah.isSurah()) SizedBox(height: 7),
        if (surah.titleInRussian.isNotEmpty)
          Text('«${surah.titleInRussian}»', style: _secondaryTextStyle),
        if (surah.titleInRussian.isNotEmpty) SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: <Widget>[
              if (surah.isSurah())
                _lineWithButton(surah.revealAt == 'Medina'
                    ? 'Мединская сура'
                    : 'Мекканская сура'),
              if (surah.isSurah()) _lineWithButton('${surah.ayatsCount} аятов'),
              if (surah.isSurah()) _lineWithButton('${surah.dzhuz} джуз'),
              if (surah.isSurah())
                _lineWithButton(
                    'в порядке ниспосылания - ${surah.revealOrder}'),
              if (surah.isSurah()) Divider(height: 35),
              HtmlText(text: surah.text),
            ],
          ),
        ),
      ],
    );
  }

  String getTitle() => surah.isSurah()
      ? 'Сура «${surah.title.toUpperCase()}»'
      : surah.title.toUpperCase();

  Widget _lineWithButton(String text) {
    return Container(
      height: 25,
      child: Row(
        children: <Widget>[
          Icon(Icons.stop, color: primaryColor, size: 16),
          SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}
