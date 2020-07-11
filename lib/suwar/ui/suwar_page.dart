import 'package:flutter/material.dart';
import 'package:tafsir/core/api.dart';
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
    _suwar = _getSuwar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: _suwar,
      builder: (_, snap) {
        if (snap.hasData)
          return _buildList(snap.data);
        else if (snap.hasError)
          return Text('Error');
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Surah>> _getSuwar() {
    return apiGet('suwar', (json) => Surah.fromJson(json));
  }

  Widget _buildList(List<Surah> suwar) {
    return ListView.separated(
      itemCount: suwar.length,
      itemBuilder: (_, index) => SurahItem(surah: suwar[index]),
      separatorBuilder: (_, __) => Divider(height: 0),
    );
  }
}
