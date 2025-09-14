import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/search/model/found_item.dart';
import 'package:tafsir/search/ui/highlighted_found_word.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';

class FoundItemWidget extends StatelessWidget {
  final String phrase;
  final FoundItem foundItem;

  const FoundItemWidget(
    this.phrase,
    this.foundItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _show(),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          SvgPicture.asset('assets/icons/search.svg', color: greyColor),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
              child: _text(context),
            ),
          ),
        ],
      ),
    );
  }

  Column _text(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HighLightedFoundWord(phrase: phrase, textItem: foundItem.textItem),
        const SizedBox(height: 3),
        Text(
          '${foundItem.surah.title}, ${foundItem.textItem.title} аят',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Future<void> _show() async {
    Modular.to.pushNamed(
      '/text/${foundItem.textItem.title}/0/0',
      arguments: foundItem.surah,
    );
    Modular.get<SuwarBloc>().add(SuwarEvent.updateActiveSurah(foundItem.surah));
  }
}
