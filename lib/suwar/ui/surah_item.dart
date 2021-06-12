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
        height: 74,
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: surah.weight > 0
                  ? BoxDecoration(
                      border: Border.all(color: const Color(0x4dBDBDC2)),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    )
                  : null,
              child: surah.weight > 0
                  ? Center(
                      child: Text(
                        surah.weight.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff0088C7),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    surah.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  if (surah.titleInRussian != '')
                    Column(
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          surah.titleInRussian,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (surah.weight > 0)
              SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${surah.ayatsCount} аятов',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Джуз: ${surah.dzhuz}',
                      style: Theme.of(context).textTheme.subtitle2,
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
