import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/suwar/model/surah.dart';

const _secondaryTextStyle = TextStyle(color: textColorGrey);

const _activeBackgroundColor = Color(0xFFDBE1FF);

class SurahItem extends StatelessWidget {
  final Surah surah;

  const SurahItem({Key key, this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = _isActive(context);
    return InkWell(
      child: Container(
        height: 70,
        color: isActive ? _activeBackgroundColor : null,
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
                          color: isActive ? primaryColor : null,
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
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: isActive ? primaryColor : null,
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
                    Text(
                      '${surah.ayatsCount} аятов',
                      style: _secondaryTextStyle,
                    ),
                    Text(
                      'Джуз: ${surah.dzhuz}',
                      style: _secondaryTextStyle,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      onTap: () {
        BlocProvider.of<ActivePageBloc>(context)
            .add(ActivePageTextShown(surah, null));
      },
    );
  }

  bool _isActive(BuildContext context) {
    final currentSurah = BlocProvider.of<ActivePageBloc>(context).state.surah;
    return currentSurah != null && currentSurah.id == surah.id;
  }
}
