import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class HtmlTextWidget extends StatelessWidget {
  final String html;

  const HtmlTextWidget(this.html, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      textStyle: const TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Color(0xff060d1b),
      ),
      hyperlinkColor: Theme.of(context).primaryColor,
      customStylesBuilder: (e) => {'text-align': 'right'},
    );
  }
}
