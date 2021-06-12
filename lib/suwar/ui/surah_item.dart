import 'package:flutter/material.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

class SurahItem extends StatelessWidget {
  final Surah surah;

  const SurahItem(this.surah, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: 70,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 70,
              child: surah.weight > 0
                  ? Center(
                      child: Text(
                        surah.weight.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (surah.titleInRussian != '')
                    Text(
                      surah.titleInRussian,
                    ),
                ],
              ),
            ),
            if (surah.weight > 0)
              SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${surah.ayatsCount} аятов',
                    ),
                    Text(
                      'Джуз: ${surah.dzhuz}',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
