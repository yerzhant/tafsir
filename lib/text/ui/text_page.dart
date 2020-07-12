import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/model/aayah.dart';
import 'package:tafsir/text/ui/aayah_info.dart';
import 'package:tafsir/text/ui/surah_info.dart';

class TextPage extends StatefulWidget {
  final Surah surah;

  const TextPage({Key key, this.surah}) : super(key: key);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  Future<List<Aayah>> _aayaat;

  @override
  void initState() {
    super.initState();
    _aayaat = RepositoryProvider.of<TafsirRepository>(context)
        .getAayaat(widget.surah);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Aayah>>(
      future: _aayaat,
      builder: (_, snapshot) {
        if (snapshot.hasData)
          return ListView.separated(
            // key: PageStorageKey('text-list'),
            itemCount: snapshot.data.length + 1,
            itemBuilder: (_, index) => index == 0
                ? SurahInfo(surah: widget.surah)
                : AayahInfo(aayah: snapshot.data[index - 1]),
            separatorBuilder: (_, __) => Divider(height: 0),
          );
        else if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
