import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          widget.textItem.textOrigin.trim(),
          textAlign: TextAlign.start,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.scheherazade(
            fontSize: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
        _translation(),
        if (widget.textItem.tafsir.isNotEmpty) ..._tafsir(),
      ],
    );
  }

  Widget _translation() => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0x33bdbdc2),
          child: HtmlWidget(
            widget.textItem.text,
            textStyle: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.5,
              color: const Color(0xff060d1b),
            ),
            customStylesBuilder: (e) => {'text-align': 'right'},
          ),
        ),
      );

  List<Widget> _tafsir() {
    return [
      const SizedBox(height: 12),
      HtmlWidget(
        widget.textItem.tafsir,
        textStyle: GoogleFonts.montserrat(
          fontSize: 14,
          height: 1.5,
          color: const Color(0xff060d1b),
        ),
        customStylesBuilder: (e) => {'text-align': 'right'},
      ),
    ];
  }
}
