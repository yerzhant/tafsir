import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/suwar/ui/surah_item.dart';

class SuwarPage extends StatefulWidget {
  const SuwarPage({Key key}) : super(key: key);

  @override
  _SuwarPageState createState() => _SuwarPageState();
}

class _SuwarPageState extends State<SuwarPage> {
  Future<List<Surah>> _suwar;

  @override
  void initState() {
    super.initState();
    _suwar = RepositoryProvider.of<TafsirRepository>(context).getSuwar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: _suwar,
      builder: (_, snap) {
        if (snap.hasData) {
          return _buildList(snap.data);
        } else if (snap.hasError) {
          return Text('Error: ${snap.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildList(List<Surah> suwar) {
    return ListView.separated(
      key: PageStorageKey('suwar-list'),
      itemCount: suwar.length,
      itemBuilder: (_, index) => SurahItem(surah: suwar[index]),
      separatorBuilder: (_, __) => Divider(height: 1),
    );
  }
}
