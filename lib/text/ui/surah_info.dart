import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/ui/html_text.dart';

const _images = '$server/media/images/surahs';

var _surahTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const _secondaryTextStyle = TextStyle(color: textColorGrey);

class SurahInfo extends StatelessWidget {
  final Surah surah;

  SurahInfo({Key key, this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CachedNetworkImage(imageUrl: '$_images/${surah.image}'),
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
                _lineWithButton(surah.revealAt == 'Madina'
                    ? 'Мединская сура'
                    : 'Мекканская сура'),
              if (surah.isSurah()) _lineWithButton('${surah.ayatsCount} аятов'),
              if (surah.isSurah()) _lineWithButton('${surah.dzhuz} джуз'),
              if (surah.isSurah())
                _lineWithButton(
                    'в порядке ниспосылания - ${surah.revealOrder}'),
              if (surah.isSurah()) Divider(height: 35),
              Row(
                children: <Widget>[
                  Expanded(child: HtmlText(text: surah.text)),
                ],
              ),
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
          Icon(Icons.stop, color: primaryColor, size: 10),
          SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}
