import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              decoration: surah.weight > 0
                  ? BoxDecoration(
                      border: Border.all(color: Colors.white30),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    )
                  : null,
              child: surah.weight > 0
                  ? Center(
                      child: Text(
                        surah.weight.toString(),
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          height: 1,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
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
                    style: Theme.of(context).textTheme.headline6?.copyWith(
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
