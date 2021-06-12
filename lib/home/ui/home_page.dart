import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/ui/suwar_list.dart';

class HomePage extends StatelessWidget {
  final SuwarBloc suwarBloc;

  const HomePage({
    Key? key,
    required this.suwarBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Suwar'),
              Tab(text: 'Bookmarks'),
            ],
          ),
          title: Text('xxx'),
        ),
        body: TabBarView(
          children: [
            SuwarList(bloc: suwarBloc),
            const Text('bookmarks'),
          ],
        ),
      ),
    );
  }
}
