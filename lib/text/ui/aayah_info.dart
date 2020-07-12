import 'package:flutter/material.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/text/model/aayah.dart';
import 'package:tafsir/text/ui/html_text.dart';

class AayahInfo extends StatelessWidget {
  final Aayah aayah;

  const AayahInfo({Key key, this.aayah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: <Widget>[
          Container(
            color: Color(0xffeef5f7),
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    aayah.textOrigin.trim(),
                    style: _aayahTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Row(
            children: <Widget>[
              Text('ПЕРЕВОД:', style: _labelStyle),
            ],
          ),
          SizedBox(height: 15),
          HtmlText(text: aayah.text),
          if (aayah.tafsir.isNotEmpty) SizedBox(height: 25),
          if (aayah.tafsir.isNotEmpty)
            Row(
              children: <Widget>[
                Text('ТАФСИР (Толкование):', style: _labelStyle),
              ],
            ),
          if (aayah.tafsir.isNotEmpty) SizedBox(height: 15),
          if (aayah.tafsir.isNotEmpty) HtmlText(text: aayah.tafsir),
        ],
      ),
    );
  }
}

const _aayahTextStyle = TextStyle(
  fontSize: 26,
);

const _labelStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
);
