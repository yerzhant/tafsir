import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/domain/model/text_item.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

import 'html_text_widget.dart';

class TextWidget extends StatelessWidget {
  final Surah surah;
  final TextItem textItem;
  final void Function(TextWidget) toggleMenu;

  const TextWidget({
    Key? key,
    required this.surah,
    required this.textItem,
    required this.toggleMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => toggleMenu(this),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 5),
          _divider(context),
          Text(
            textItem.textOrigin.trim(),
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
          if (textItem.tafsir.isNotEmpty) ..._tafsir(),
        ],
      ),
    );
  }

  Row _divider(BuildContext context) {
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
              textItem.title,
              style: TextStyle(
                fontSize: 13,
                height: 1,
                letterSpacing: -1,
                fontWeight: FontWeight.w900,
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
        child: BlocBuilder<ThemeCubit, ThemeState>(
          bloc: Modular.get(),
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(10),
              color: state.translationBackground,
              child: HtmlTextWidget(textItem.text),
            );
          },
        ),
      );

  List<Widget> _tafsir() {
    return [
      const SizedBox(height: 12),
      HtmlTextWidget(textItem.tafsir),
    ];
  }

  void share() {
    final subject = '${surah.title}, ${textItem.weight} аят.';

    var text = '$subject\n\n';
    text += '${textItem.textOrigin}\n\n';
    text += textItem.text.parseHtml();

    if (textItem.tafsir.isNotEmpty) {
      text += '\n\n';
      text += textItem.tafsir.parseHtml();
    }

    Share.share(text, subject: subject);
  }
}
