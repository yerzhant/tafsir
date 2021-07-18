import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tafsir/common/ui/widget/circular_progress.dart';
import 'package:tafsir/common/ui/widget/rejection_widget.dart';
import 'package:tafsir/go_to_aayah/bloc/go_to_aayah_bloc.dart';
import 'package:tafsir/go_to_aayah/ui/cancel_go_to_aayah.dart';
import 'package:tafsir/go_to_aayah/ui/go_to_aayah_slider.dart';
import 'package:tafsir/go_to_aayah/ui/go_to_aayah_number.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';
import 'package:tafsir/settings/repo/settings_repo.dart';
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

const _goToAayahOpacityDuration = 300;

class TextPage extends StatefulWidget {
  final TextBloc bloc;
  final Surah surah;
  final int index;
  final int initialIndex;
  final double initialOffset;

  TextPage({
    Key? key,
    required this.bloc,
    required this.surah,
    required this.index,
    required this.initialIndex,
    required this.initialOffset,
  }) : super(key: key) {
    bloc.add(TextEvent.load(surah));
  }

  @override
  _TextPageState createState() => _TextPageState();
}

const _duration = Duration(milliseconds: 400);

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
    begin: const Offset(0, -1.8),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _toolsAnimationController,
    curve: Curves.easeOut,
  ));
  late final _toolsOffset = Tween(
    begin: const Offset(0, 1.2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _toolsAnimationController,
    curve: Curves.easeOut,
  ));
  late final _surahMenuOffset = Tween(
    begin: const Offset(0, 1.3),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _surahMenuAnimationController,
    curve: Curves.easeOut,
  ));
  late final _textMenuOffset = Tween(
    begin: const Offset(0, 1.2),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _textMenuAnimationController,
    curve: Curves.easeOut,
  ));

  late SurahWidget _surahWidget;
  final SelectedTextWidget _selectedTextWidget = SelectedTextWidget();

  var _goToAayahOpacity = 0.0;
  var _previousIndex = 0;
  var _previousOffset = 0.0;

  var _canSlideOutEverything = false;

  @override
  void initState() {
    super.initState();

    _hideSystemUIOverlays();

    _toolsAnimationController.forward();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        _toolsAnimationController.reverse();
        _canSlideOutEverything = true;
      },
    );

    if (widget.index != 0) {
      _scrollTo(widget.index);
    }

    _itemPositionsListener.itemPositions.addListener(_positionsListener);

    Modular.get<GoToAayahBloc>().aayaatCount = widget.surah.ayatsCount ?? 0;
  }

  Future<void> _scrollTo(int index, [double offset = 0]) async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _itemScrollController.scrollTo(
      index: index,
      alignment: offset,
      duration: const Duration(seconds: 1),
    );
  }

  void _positionsListener() {
    if (_canSlideOutEverything) {
      _slideOutEverything();
    }

    final itemPosition = _itemPositionsListener.itemPositions.value.first;
    final textPosition = SavedTextPosition(
      widget.surah.weight,
      itemPosition.index,
      itemPosition.itemLeadingEdge,
    );

    Modular.get<SettingsRepo>().saveTextPosition(textPosition);
  }

  void _slideOutEverything() {
    if (_surahMenuAnimationController.status == AnimationStatus.completed) {
      _surahMenuAnimationController.reverse();
      _hideSystemUIOverlays();
    }
    if (_textMenuAnimationController.status == AnimationStatus.completed) {
      _textMenuAnimationController.reverse();
      _hideSystemUIOverlays();
    }
    if (_toolsAnimationController.status == AnimationStatus.completed) {
      _toolsAnimationController.reverse();
      _hideSystemUIOverlays();
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

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
          (items) => Stack(
            children: [
              _itemsGestureDetector(items),
              _header(),
              if (widget.surah.isSurah()) ...[
                _progressBar(items),
                _goToAayahSlider(),
                _goToAayahNumberConsumer(),
                _cancelGoToAayah(),
              ],
              _surahContextMenu(),
              _textContextMenu(),
              _tools(),
            ],
          ),
          inProgress: () => const Center(child: CircularProgress()),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () => widget.bloc.add(TextEvent.load(widget.surah)),
          ),
        ),
      ),
    );
  }

  Widget _cancelGoToAayah() => BlocBuilder<GoToAayahBloc, GoToAayahState>(
        bloc: Modular.get(),
        builder: (context, state) => state.maybeWhen(
          goTo: (number) => CancelGoToAayah(number, () {
            _scrollTo(_previousIndex, _previousOffset);
          }),
          orElse: () => const SizedBox.shrink(),
        ),
      );

  Widget _goToAayahSlider() => BlocBuilder<GoToAayahBloc, GoToAayahState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return AnimatedOpacity(
            opacity: _goToAayahOpacity,
            duration: const Duration(milliseconds: _goToAayahOpacityDuration),
            child: GoToAayahSlider(
              state.maybeWhen(
                active: (position, _) => position,
                semiActive: (position, _) => position,
                orElse: () => null,
              ),
            ),
          );
        },
      );

  BlocConsumer<GoToAayahBloc, GoToAayahState> _goToAayahNumberConsumer() {
    return BlocConsumer<GoToAayahBloc, GoToAayahState>(
      bloc: Modular.get(),
      listener: (_, state) {
        state.when(
          active: (_, __) {
            _goToAayahOpacity = 1;
          },
          semiActive: (_, __) {
            _goToAayahOpacity = .5;
          },
          goTo: (number) async {
            _goToAayahOpacity = 0;

            final settings = Modular.get<SettingsRepo>();
            final savedPosition = await settings.getSavedTextPosition();
            if (savedPosition != null) {
              _previousIndex = savedPosition.index;
              _previousOffset = savedPosition.leadingEdge;
            }

            _scrollTo(number);
          },
          inactive: (_) {
            _goToAayahOpacity = 0;
          },
        );
      },
      builder: (context, state) => _goToAayahNumber(
        state.when(
          active: (_, number) => number,
          semiActive: (_, number) => number,
          goTo: (number) => number,
          inactive: (number) => number,
        ),
      ),
    );
  }

  Center _goToAayahNumber(int number) => Center(
        child: AnimatedOpacity(
          opacity: _goToAayahOpacity,
          duration: const Duration(milliseconds: _goToAayahOpacityDuration),
          child: GoToAayahNumber(number),
        ),
      );

  Positioned _tools() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: SlideTransition(
        position: _toolsOffset,
        child: TextTools(_toolsAnimationController),
      ),
    );
  }

  Positioned _textContextMenu() {
    return Positioned(
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
    );
  }

  Positioned _surahContextMenu() {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: SlideTransition(
        position: _surahMenuOffset,
        child: SurahContextMenu(widget.surah, _shareSurah),
      ),
    );
  }

  Positioned _progressBar(List<TextItem> items) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: ProgressWidget(
        items.length,
        _itemPositionsListener,
      ),
    );
  }

  SlideTransition _header() {
    return SlideTransition(
      position: _headerOffset,
      child: TextHeader(widget.surah),
    );
  }

  GestureDetector _itemsGestureDetector(List<TextItem> items) {
    return GestureDetector(
      onLongPress: () {
        if (_surahMenuAnimationController.status == AnimationStatus.completed) {
          _surahMenuAnimationController.reverse();
          _hideSystemUIOverlays();
        } else if (_textMenuAnimationController.status ==
            AnimationStatus.completed) {
          _textMenuAnimationController.reverse();
          _hideSystemUIOverlays();
        }

        if (_toolsAnimationController.status == AnimationStatus.completed) {
          _toolsAnimationController.reverse();
          _hideSystemUIOverlays();
        } else {
          _toolsAnimationController.forward();
          _showSystemUIOverlays();
        }
      },
      child: _items(items),
    );
  }

  ScrollablePositionedList _items(List<TextItem> items) {
    return ScrollablePositionedList.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      key: PageStorageKey('text-list-${widget.surah.id}'),
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      initialScrollIndex: widget.initialIndex,
      initialAlignment: widget.initialOffset,
      itemCount: items.length + 1,
      itemBuilder: (_, index) => index == 0 ? _surah() : _text(items, index),
    );
  }

  Widget _surah() => BlocBuilder<SettingsBloc, SettingsState>(
        bloc: Modular.get(),
        builder: (context, state) {
          if (state.showTafsir) {
            return SurahWidget(
              surah: widget.surah,
              settings: state,
              toggleMenu: _toggleSurahContextMenu,
            );
          } else {
            return Container();
          }
        },
      );

  TextWidget _text(List<TextItem> items, int index) {
    return TextWidget(
      surah: widget.surah,
      textItem: items[index - 1],
      toggleMenu: _toggleTextContextMenu,
    );
  }

  void _toggleSurahContextMenu(SurahWidget surahWidget) {
    _surahWidget = surahWidget;

    if (_toolsAnimationController.status == AnimationStatus.completed) {
      _toolsAnimationController.reverse();
      _hideSystemUIOverlays();
    } else if (_textMenuAnimationController.status ==
        AnimationStatus.completed) {
      _textMenuAnimationController.reverse();
      _hideSystemUIOverlays();
    } else if (_surahMenuAnimationController.status ==
        AnimationStatus.dismissed) {
      _showSystemUIOverlays();
      _surahMenuAnimationController.forward();
    } else {
      _surahMenuAnimationController.reverse();
      _hideSystemUIOverlays();
    }
  }

  void _toggleTextContextMenu(TextWidget textWidget) {
    _selectedTextWidget.select(textWidget);

    if (_toolsAnimationController.status == AnimationStatus.completed) {
      _toolsAnimationController.reverse();
      _hideSystemUIOverlays();
    } else if (_surahMenuAnimationController.status ==
        AnimationStatus.completed) {
      _surahMenuAnimationController.reverse();
      _hideSystemUIOverlays();
    } else if (_textMenuAnimationController.status ==
        AnimationStatus.dismissed) {
      _textMenuAnimationController.forward();
      _showSystemUIOverlays();
    } else {
      _textMenuAnimationController.reverse();
      _hideSystemUIOverlays();
    }
  }

  void _shareSurah() {
    _surahWidget.share();
    _toggleSurahContextMenu(_surahWidget);
  }

  void _showSystemUIOverlays() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  void _hideSystemUIOverlays() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class SelectedTextWidget extends ChangeNotifier {
  TextWidget? widget;

  void select(TextWidget widget) {
    this.widget = widget;
    notifyListeners();
  }
}
