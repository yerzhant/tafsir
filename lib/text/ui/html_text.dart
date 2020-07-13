import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tafsir/constants.dart';

class HtmlText extends StatelessWidget {
  final String text;

  const HtmlText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      text,
      customStylesBuilder: (element) {
        final styles = <String>[];

        if (element.localName == 'blockquote')
          styles.addAll(['margin', '0', 'padding', '10px 15px']);

        if (element.localName == 'blockquote' && element.className == 'blue')
          styles.addAll(['background-color', '#eef5ff']);

        if (element.localName == 'blockquote' && element.className == 'green')
          styles.addAll(['background-color', '#f5fffa']);

        if (element.localName == 'ul' || element.localName == 'ol')
          styles.addAll(['margin-left', '16px', 'padding', '0']);

        if (element.className == 'snoski')
          styles.addAll(['padding', '10px', 'background-color', '#eef5f7']);

        if (element.className == 'specdiv')
          styles.addAll(['padding', '10px', 'background-color', '#f5f5f5']);

        return styles;
      },
      textStyle: TextStyle(height: 1.6),
      hyperlinkColor: primaryColor,
    );
  }
}
