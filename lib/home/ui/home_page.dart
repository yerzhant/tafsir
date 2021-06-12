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
              Tab(text: 'Суры'),
              Tab(text: 'Закладки'),
            ],
          ),
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 57,
                height: 50,
              ),
              const Text('Тафсир Azan.ru'),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SuwarList(bloc: suwarBloc),
            const Placeholder(),
          ],
        ),
      ),
    );
  }
}
