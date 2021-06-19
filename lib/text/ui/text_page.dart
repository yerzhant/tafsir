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
import 'package:tafsir/text/ui/widget/surah_context_menu.dart';
import 'package:tafsir/text/ui/widget/text_context_menu.dart';
import 'package:tafsir/text/ui/widget/text_header.dart';
import 'package:tafsir/text/ui/widget/text_widget.dart';
import 'package:tafsir/text/ui/widget/tool/text_tools.dart';

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

const _duration = Duration(milliseconds: 200);

class _TextPageState extends State<TextPage> with TickerProviderStateMixin {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  late ItemPosition _itemPosition;

  late final _toolsAnimationController = AnimationController(
    duration: _duration,
    vsync: this,
  );
  late final _surahAnimationController = AnimationController(
    duration: _duration,
    vsync: this,
  );
  late final _textAnimationController = AnimationController(
    duration: _duration,
    vsync: this,
  );
  late final _headerOffset = Tween(
    begin: Offset.zero,
    end: const Offset(0, -2),
  ).animate(CurvedAnimation(
    parent: _toolsAnimationController,
    curve: Curves.easeIn,
  ));
  late final _toolsOffset = Tween(
    begin: Offset.zero,
    end: const Offset(0, 2),
  ).animate(CurvedAnimation(
    parent: _toolsAnimationController,
    curve: Curves.easeIn,
  ));
  late final _surahOffset = Tween(
    begin: const Offset(0, 2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _surahAnimationController,
    curve: Curves.easeIn,
  ));
  late final _textOffset = Tween(
    begin: const Offset(0, 2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _textAnimationController,
    curve: Curves.easeIn,
  ));

  late SurahWidget _surahWidget;
  TextWidget? _textWidget;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () => _toolsAnimationController.forward(),
    );

    _itemPositionsListener.itemPositions.addListener(_positionsListener);
  }

  void _positionsListener() {
    _itemPosition = _itemPositionsListener.itemPositions.value.first;
  }

  @override
  void dispose() {
    _toolsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TextBloc, TextState>(
        bloc: widget.bloc,
        builder: (_, state) => state.when(
          (items) => SafeArea(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_surahAnimationController.status ==
                        AnimationStatus.completed) {
                      _surahAnimationController.reverse();
                    } else if (_toolsAnimationController.status ==
                        AnimationStatus.completed) {
                      _toolsAnimationController.reverse();
                    } else {
                      _toolsAnimationController.forward();
                    }
                  },
                  child: _items(items),
                ),
                SlideTransition(
                  position: _headerOffset,
                  child: TextHeader(widget.surah),
                ),
                if (widget.surah.isSurah())
                  Positioned(
                    right: 8,
                    left: 8,
                    bottom: 14,
                    child: ProgressWidget(
                      items.length,
                      _itemPositionsListener,
                    ),
                  ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SlideTransition(
                    position: _surahOffset,
                    child: SurahContextMenu(widget.surah, _shareSurah),
                  ),
                ),
                // Positioned(
                //   right: 0,
                //   left: 0,
                //   bottom: 0,
                //   // child: SlideTransition(
                //   //   position: _toolsOffset,
                //   //   child: TextTools(_animationController),
                //   // ),
                //   child: TextContextMenu(widget.surah),
                // ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SlideTransition(
                    position: _toolsOffset,
                    child: TextTools(_toolsAnimationController),
                  ),
                ),
              ],
            ),
          ),
          inProgress: () => const Center(child: CircularProgress()),
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
          ? SurahWidget(widget.surah, _toggleSurahContextMenu)
          : TextWidget(
              surah: widget.surah,
              textItem: items[index - 1],
              toggleMenu: _toggleTextContextMenu,
            ),
    );
  }

  void _toggleSurahContextMenu(SurahWidget surahWidget) {
    _surahWidget = surahWidget;

    if (_surahAnimationController.status == AnimationStatus.dismissed) {
      _surahAnimationController.forward();
    } else {
      _surahAnimationController.reverse();
    }
  }

  void _toggleTextContextMenu(TextWidget textWidget) {
    _textWidget = textWidget;

    if (_textAnimationController.status == AnimationStatus.dismissed) {
      _textAnimationController.forward();
    } else {
      _textAnimationController.reverse();
    }
  }

  void _shareSurah() {
    _surahWidget.share();
    _toggleSurahContextMenu(_surahWidget);
  }
}
