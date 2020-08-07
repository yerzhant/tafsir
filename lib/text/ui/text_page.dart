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

  Future<List<Aayah>> _aayaat;

  @override
  void initState() {
    super.initState();

    _aayaat = RepositoryProvider.of<TafsirRepository>(context)
        .getAayaat(widget.surah);

    if (widget.aayah != null)
      _aayaat.whenComplete(() async {
        await Future.delayed(Duration(milliseconds: 150));
        _scrollTo(widget.aayah);
      });
  }

  void _scrollTo(int aayah) {
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
          return BlocListener<ActivePageBloc, ActivePageState>(
            listener: (_, state) {
              if (state is ActivePageTextScrollTo) _scrollTo(state.aayah);
            },
            child: ScrollablePositionedList.separated(
              key: PageStorageKey('text-list-${widget.surah.id}'),
              itemScrollController: _itemScrollController,
              itemCount: snapshot.data.length + 1,
              itemBuilder: (_, index) => index == 0
                  ? SurahInfo(surah: widget.surah)
                  : AayahInfo(aayah: snapshot.data[index - 1]),
              separatorBuilder: (_, __) => Divider(height: 1),
            ),
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
