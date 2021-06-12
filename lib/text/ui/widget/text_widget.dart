import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';

class TextWidget extends StatefulWidget {
  final Surah surah;
  final TextItem textItem;

  const TextWidget({
    Key? key,
    required this.surah,
    required this.textItem,
  }) : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.textItem.textOrigin),
        ..._translation(),
        if (widget.textItem.tafsir.isNotEmpty) ..._tafsir(),
      ],
    );
  }

  List<Widget> _translation() {
    return [
      const SizedBox(height: 20),
      HtmlWidget(widget.textItem.text),
    ];
  }

  List<Widget> _tafsir() {
    return [
      const SizedBox(height: 5),
      const Divider(height: 20),
      HtmlWidget(widget.textItem.tafsir),
    ];
  }
}
