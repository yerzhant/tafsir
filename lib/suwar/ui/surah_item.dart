import 'package:flutter/material.dart';
import 'package:tafsir/suwar/model/surah.dart';

const _secondaryTextStyle = TextStyle(color: Colors.grey);

class SurahItem extends StatelessWidget {
  final Surah surah;

  const SurahItem({Key key, this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 70,
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              child: surah.weight > 0
                  ? Center(
                      child: Text(
                        surah.weight.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    )
                  : null,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    surah.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  if (surah.titleInRussian != '')
                    Text(
                      surah.titleInRussian,
                      style: _secondaryTextStyle,
                    ),
                ],
              ),
            ),
            if (surah.weight > 0)
              Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${surah.ayatsCount} аятов',
                        style: _secondaryTextStyle),
                    Text('Джуз: ${surah.dzhuz}', style: _secondaryTextStyle),
                  ],
                ),
              ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
