import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tafsir/common/ui/widget/circular_progress.dart';
import 'package:tafsir/common/ui/widget/rejection_widget.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/bloc/text_bloc.dart';
import 'package:tafsir/text/domain/model/text_item.dart';
import 'package:tafsir/text/ui/widget/progress_widget.dart';
import 'package:tafsir/text/ui/widget/surah_widget.dart';
import 'package:tafsir/text/ui/widget/text_widget.dart';

class TextPage extends StatefulWidget {
  final TextBloc bloc;
  final Surah surah;
  final int? itemNumber;

  TextPage({
    Key? key,
    required this.bloc,
    required this.surah,
    this.itemNumber,
  }) : super(key: key) {
    bloc.add(TextEvent.load(surah));
  }

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TextBloc, TextState>(
        bloc: widget.bloc,
        builder: (_, state) => state.when(
          (items) => Stack(
            children: [
              _items(items),
              if (widget.surah.isSurah())
                Positioned(
                  right: 8,
                  left: 8,
                  bottom: 14,
                  child: ProgressWidget(
                    items.length + 1,
                    _itemPositionsListener,
                  ),
                ),
            ],
          ),
          inProgress: () => const CircularProgress(),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () {},
          ),
        ),
      ),
    );
  }

  ScrollablePositionedList _items(List<TextItem> items) {
    return ScrollablePositionedList.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      key: PageStorageKey('text-list-${widget.surah.id}'),
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      itemCount: items.length + 1,
      itemBuilder: (_, index) => index == 0
          ? SurahWidget(widget.surah)
          : TextWidget(
              surah: widget.surah,
              textItem: items[index - 1],
            ),
    );
  }
}
