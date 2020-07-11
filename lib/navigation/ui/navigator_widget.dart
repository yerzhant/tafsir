import 'package:flutter/material.dart';
import 'package:tafsir/suwar/ui/suwar_page.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Тафсир')),
      body: SuwarPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Суры'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            title: Text('Текст'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            title: Text('Закладки'),
          ),
        ],
        currentIndex: 1,
      ),
    );
  }
}
