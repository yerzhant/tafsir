import 'package:flutter/material.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

const _server = 'https://azan.ru';
const _images = '$_server/media/images/surahs';

const _padding = 15.0;

var _surahTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.grey[800],
);

const _secondaryTextStyle = TextStyle(color: Colors.grey);

class SurahInfo extends StatefulWidget {
  final Surah surah;

  SurahInfo({Key key, this.surah}) : super(key: key);

  @override
  _SurahInfoState createState() => _SurahInfoState();
}

class _SurahInfoState extends State<SurahInfo> {
  var _descHeight = 1.0;
  WebViewPlusController _webViewPlusController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network('$_images/${widget.surah.image}'),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.surah.weight.toString(), style: _surahTitleStyle),
            SizedBox(width: 10),
            Text(
              'Сура «${widget.surah.title.toUpperCase()}»',
              style: _surahTitleStyle,
            ),
          ],
        ),
        SizedBox(height: 7),
        Text('«${widget.surah.titleInRussian}»', style: _secondaryTextStyle),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(_padding),
          child: Column(
            children: <Widget>[
              _lineWithButton(widget.surah.revealAt == 'Medina'
                  ? 'Мединская сура'
                  : 'Мекканская сура'),
              _lineWithButton('${widget.surah.ayatsCount} аятов'),
              _lineWithButton('${widget.surah.dzhuz} джуз'),
              _lineWithButton(
                  'в порядке ниспосылания - ${widget.surah.revealOrder}'),
            ],
          ),
        ),
        Divider(height: 0),
        Padding(
          padding: const EdgeInsets.all(_padding),
          child: SizedBox(
            height: _descHeight,
            child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webViewPlusController = controller;
                controller.loadString(
                    widget.surah.text + '<style>div {color: red;} </style>');
              },
              onPageFinished: (url) async {
                var height = await _webViewPlusController.getHeight();
                setState(() {
                  _descHeight = height;
                });
              },
            ),
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
