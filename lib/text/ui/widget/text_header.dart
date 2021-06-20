import 'package:flutter/material.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

class TextHeader extends StatelessWidget {
  final Surah surah;

  const TextHeader(this.surah, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      child: Container(
        height: 64,
        padding: const EdgeInsets.all(7),
        color: Theme.of(context).primaryColor,
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
                        style: const TextStyle(
                          fontSize: 22,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryVariant,
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
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  if (surah.titleInRussian != '')
                    Column(
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          surah.titleInRussian,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: Colors.white54,
                                  ),
                        ),
                      ],
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
