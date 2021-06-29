import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ext/string_ext.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/search/model/found_item.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';

class FoundItemWidget extends StatelessWidget {
  final FoundItem foundItem;

  const FoundItemWidget(this.foundItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _show(),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          const Icon(Icons.search, color: greyColor),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
        Text(
          foundItem.textItem.text.parseHtml(),
          style: Theme.of(context).textTheme.headline6?.copyWith(height: 1.29),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 3),
        Text(
          '${foundItem.surah.title}, ${foundItem.textItem.title} аят',
          style: Theme.of(context).textTheme.subtitle1,
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