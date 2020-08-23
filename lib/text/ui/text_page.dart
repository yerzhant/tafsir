import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/model/aayah.dart';
import 'package:tafsir/text/ui/aayah_info.dart';
import 'package:tafsir/text/ui/surah_info.dart';

class TextPage extends StatefulWidget {
  final Surah surah;
  final int aayah;

  const TextPage({Key key, this.surah, this.aayah}) : super(key: key);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  Future<List<Aayah>> _aayaat;

  @override
  void initState() {
    super.initState();

    _aayaat = RepositoryProvider.of<TafsirRepository>(context)
        .getAayaat(widget.surah);

    if (widget.aayah != null)
      _aayaat.whenComplete(() {
        _scrollTo(widget.aayah);
      });

    _itemPositionsListener.itemPositions.addListener(() {
      if (_itemPositionsListener.itemPositions.value.isEmpty) return;

      final item = _itemPositionsListener.itemPositions.value.first;
      final InitialTextPosition initialTextPosition = InitialTextPosition(
        widget.surah.weight,
        item.index,
        item.itemLeadingEdge,
      );

      RepositoryProvider.of<TafsirRepository>(context)
          .saveInitialTextPosition(initialTextPosition);
    });
  }

  void _scrollTo(int aayah) async {
    await Future.delayed(Duration(milliseconds: 250));
    _itemScrollController.scrollTo(
      index: aayah,
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Aayah>>(
      future: _aayaat,
      builder: (_, snapshot) {
        if (snapshot.hasData)
          return BlocConsumer<ActivePageBloc, ActivePageState>(
            listener: (_, state) {
              if (state is ActivePageTextScrollTo) _scrollTo(state.aayah);
            },
            builder: (_, state) {
              if (state is ActivePageText)
                return ScrollablePositionedList.separated(
                  key: PageStorageKey('text-list-${widget.surah.id}'),
                  itemScrollController: _itemScrollController,
                  itemPositionsListener: _itemPositionsListener,
                  initialScrollIndex: state.initialIndex,
                  initialAlignment: state.initialLeadingEdge,
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (_, index) => index == 0
                      ? SurahInfo(surah: widget.surah)
                      : AayahInfo(
                          surah: widget.surah,
                          aayah: snapshot.data[index - 1],
                        ),
                  separatorBuilder: (_, __) => Divider(height: 1),
                );
              else
                return Center(child: CircularProgressIndicator());
            },
          );
        else if (snapshot.hasError) {
          if (snapshot.error is SocketException)
            return Center(child: Text('Нет соединения с сервером.'));
          return Center(child: Text('Error: ${snapshot.error}'));
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
