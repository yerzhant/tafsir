import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/bloc/settings_bloc.dart';
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
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 45),
            Spacer(),
            if (surah.isSurah())
              Text(surah.weight.toString(), style: _surahTitleStyle),
            if (surah.isSurah()) SizedBox(width: 10),
            Text(_getTitle(), style: _surahTitleStyle),
            Spacer(),
            IconButton(
              iconSize: iconSize,
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.share),
              onPressed: _share,
            ),
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
                _lineWithButton(
                  surah.revealAt == 'Madina'
                      ? 'Мединская сура'
                      : 'Мекканская сура',
                  context,
                ),
              if (surah.isSurah())
                _lineWithButton(
                  '${surah.ayatsCount} аятов',
                  context,
                ),
              if (surah.isSurah())
                _lineWithButton(
                  '${surah.dzhuz} джуз',
                  context,
                ),
              if (surah.isSurah())
                _lineWithButton(
                  'в порядке ниспосылания - ${surah.revealOrder}',
                  context,
                ),
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

  String _getTitle() => surah.isSurah()
      ? 'Сура «${surah.title.toUpperCase()}»'
      : surah.title.toUpperCase();

  Widget _lineWithButton(String text, BuildContext context) {
    return Container(
      height: 25,
      child: Row(
        children: <Widget>[
          Icon(Icons.stop, color: Theme.of(context).primaryColor, size: 10),
          SizedBox(width: 5),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themState) {
              return BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  final _textStyle = TextStyle(
                    fontSize: state.fontSize,
                    color: themState.htmlTextColor,
                  );
                  return Text(text, style: _textStyle);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _share() {
    var subject = '';
    if (surah.isSurah()) subject = '${surah.weight} ';
    subject += _getTitle();

    var text = '$subject\n';

    if (surah.isSurah()) {
      if (surah.titleInRussian.isNotEmpty)
        text += '«${surah.titleInRussian}»\n';

      text += '\n';
      text += '• ';
      text += surah.revealAt == 'Madina' ? 'Мединская сура' : 'Мекканская сура';
      text += '\n';
      text += '• ${surah.ayatsCount} аятов\n';
      text += '• ${surah.dzhuz} джуз\n';
      text += '• в порядке ниспосылания - ${surah.revealOrder}\n';
    }

    text += '\n';
    text += _htmlToString(surah.text);

    Share.share(text, subject: subject);
  }

  String _htmlToString(String html) {
    final doc = parse(html);
    return parse(doc.body.text).documentElement.text.trim();
  }
}
