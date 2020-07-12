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
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(surah.weight.toString(), style: _surahTitleStyle),
            SizedBox(width: 10),
            Text(
              'Сура «${surah.title.toUpperCase()}»',
              style: _surahTitleStyle,
            ),
          ],
        ),
        SizedBox(height: 7),
        Text('«${surah.titleInRussian}»', style: _secondaryTextStyle),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: <Widget>[
              _lineWithButton(surah.revealAt == 'Medina'
                  ? 'Мединская сура'
                  : 'Мекканская сура'),
              _lineWithButton('${surah.ayatsCount} аятов'),
              _lineWithButton('${surah.dzhuz} джуз'),
              _lineWithButton('в порядке ниспосылания - ${surah.revealOrder}'),
              Divider(height: 35),
              HtmlText(text: surah.text),
            ],
          ),
        ),
      ],
    );
  }

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
