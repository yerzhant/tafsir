import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
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
  final int index;

  TextPage({
    Key? key,
    required this.bloc,
    required this.surah,
    required this.index,
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

  late final _toolsAnimationController = AnimationController(
    duration: _duration,
    vsync: this,
  );
  late final _surahMenuAnimationController = AnimationController(
    duration: _duration,
    vsync: this,
  );
  late final _textMenuAnimationController = AnimationController(
    duration: _duration,
    vsync: this,
  );
  late final _headerOffset = Tween(
    begin: const Offset(0, -2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _toolsAnimationController,
    curve: Curves.easeIn,
  ));
  late final _toolsOffset = Tween(
    begin: const Offset(0, 2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _toolsAnimationController,
    curve: Curves.easeIn,
  ));
  late final _surahMenuOffset = Tween(
    begin: const Offset(0, 2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _surahMenuAnimationController,
    curve: Curves.easeIn,
  ));
  late final _textMenuOffset = Tween(
    begin: const Offset(0, 2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _textMenuAnimationController,
    curve: Curves.easeIn,
  ));

  late SurahWidget _surahWidget;
  final SelectedTextWidget _selectedTextWidget = SelectedTextWidget();

  @override
  void initState() {
    super.initState();

    _toolsAnimationController.forward();

    Future.delayed(
      const Duration(seconds: 1),
      () => _toolsAnimationController.reverse(),
    );

    if (widget.index != 0) {
      _scrollTo(widget.index);
    }

    _itemPositionsListener.itemPositions.addListener(_positionsListener);
  }

  Future<void> _scrollTo(int index) async {
    await Future.delayed(const Duration(milliseconds: 250));
    await _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
    );
  }

  late ItemPosition _itemPosition;

  void _positionsListener() {
    _slideOutEverything();

    _itemPosition = _itemPositionsListener.itemPositions.value.first;
  }

  void _slideOutEverything() {
    if (_surahMenuAnimationController.status == AnimationStatus.completed) {
      _surahMenuAnimationController.reverse();
    }
    if (_textMenuAnimationController.status == AnimationStatus.completed) {
      _textMenuAnimationController.reverse();
    }
    if (_toolsAnimationController.status == AnimationStatus.completed) {
      _toolsAnimationController.reverse();
    }
  }

  @override
  void dispose() {
    _toolsAnimationController.dispose();
    _surahMenuAnimationController.dispose();
    _textMenuAnimationController.dispose();
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
                    if (_surahMenuAnimationController.status ==
                        AnimationStatus.completed) {
                      _surahMenuAnimationController.reverse();
                    } else if (_textMenuAnimationController.status ==
                        AnimationStatus.completed) {
                      _textMenuAnimationController.reverse();
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
                    position: _surahMenuOffset,
                    child: SurahContextMenu(widget.surah, _shareSurah),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SlideTransition(
                    position: _textMenuOffset,
                    child: ChangeNotifierProvider(
                      create: (_) => _selectedTextWidget,
                      child: TextContextMenu(widget.surah),
                    ),
                  ),
                ),
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
      // itemScrollController: _itemScrollController,
      // itemPositionsListener: _itemPositionsListener,
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

    if (_surahMenuAnimationController.status == AnimationStatus.dismissed) {
      _surahMenuAnimationController.forward();
    } else {
      _surahMenuAnimationController.reverse();
    }
  }

  void _toggleTextContextMenu(TextWidget textWidget) {
    _selectedTextWidget.select(textWidget);

    if (_textMenuAnimationController.status == AnimationStatus.dismissed) {
      _textMenuAnimationController.forward();
    } else {
      _textMenuAnimationController.reverse();
    }
  }

  void _shareSurah() {
    _surahWidget.share();
    _toggleSurahContextMenu(_surahWidget);
  }
}

class SelectedTextWidget extends ChangeNotifier {
  TextWidget? widget;

  void select(TextWidget widget) {
    this.widget = widget;
    notifyListeners();
  }
}
