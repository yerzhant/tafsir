import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';

import 'html_text_widget.dart';

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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const SizedBox(height: 5),
        _divider(),
        Text(
          widget.textItem.textOrigin.trim(),
          textAlign: TextAlign.start,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.scheherazade(
            fontSize: 30,
            height: 1.3,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 7),
        _translation(),
        if (widget.textItem.tafsir.isNotEmpty) ..._tafsir(),
      ],
    );
  }

  Row _divider() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x4dBDBDC2)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              widget.textItem.title,
              style: GoogleFonts.lato(
                fontSize: 13,
                height: 1,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 11),
        const Expanded(child: Divider(height: 1)),
      ],
    );
  }

  Widget _translation() => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0x33bdbdc2),
          child: HtmlTextWidget(widget.textItem.text),
        ),
      );

  List<Widget> _tafsir() {
    return [
      const SizedBox(height: 12),
      HtmlTextWidget(widget.textItem.tafsir),
    ];
  }
}
