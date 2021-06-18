import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

class SurahItem extends StatelessWidget {
  final Surah surah;

  const SurahItem(this.surah, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/text', arguments: surah);
      },
      child: SizedBox(
        height: 74,
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x4dbdbdc2)),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Center(
                child: surah.isSurah()
                    ? Text(
                        surah.weight.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          height: 1,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(1),
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    surah.isSurah() ? surah.title : surah.title.toUpperCase(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  if (surah.titleInRussian != '')
                    Column(
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          surah.titleInRussian,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (surah.isSurah())
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${surah.ayatsCount} аятов',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Джуз: ${surah.dzhuz}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
