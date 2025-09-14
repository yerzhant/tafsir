import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/text/domain/model/text_item.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class HighLightedFoundWord extends StatelessWidget {
  final String phrase;
  final TextItem textItem;

  const HighLightedFoundWord({
    Key? key,
    required this.phrase,
    required this.textItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parts = _getStrings();

    if (parts.length == 1) {
      return Text(parts.first);
    } else {
      return RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: parts.first,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.29),
          children: [
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, 2),
                child: BlocBuilder<ThemeCubit, ThemeState>(
                  bloc: Modular.get(),
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: state.foundPhraseBackground,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        parts[1],
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(height: 1.29),
                      ),
                    );
                  },
                ),
              ),
            ),
            TextSpan(text: parts.last),
          ],
        ),
      );
    }
  }

  List<String> _getStrings() => _split(textItem.text).fold(
        () => _split(textItem.tafsir).fold(
          () => [textItem.text.parseHtml()],
          (a) => a,
        ),
        (a) => a,
      );

  Option<List<String>> _split(String html) {
    final text = html.parseHtml().replaceAll('\n', '');
    final index = text.toLowerCase().indexOf(phrase.toLowerCase());

    if (index == -1) return none();

    var before = text.substring(0, index);
    final word = text.substring(index, index + phrase.length);
    final after = text.substring(index + phrase.length);

    final splitedBefore = before.split(' ');
    if (splitedBefore.length > 5) {
      before = '… ${splitedBefore.skip(splitedBefore.length - 5).join(' ')}';
    }

    return some([before, word, after]);
  }
}
