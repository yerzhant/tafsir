import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/suwar/model/surah.dart';

const _secondaryTextStyle = TextStyle(color: textColorGrey);

class SurahItem extends StatelessWidget {
  final Surah surah;

  const SurahItem({Key key, this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = BlocProvider.of<ThemeBloc>(context).state;

    final isActive = _isActive(context);
    return InkWell(
      onTap: () {
        BlocProvider.of<ActivePageBloc>(context).add(
          ActivePageTextShown(
            surah,
            BlocProvider.of<ActivePageBloc>(context).state.textHistory,
            null,
          ),
        );
      },
      child: Container(
        height: 70,
        color: isActive ? themeState.activeSurahItemBackgroundColor : null,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 70,
              child: surah.weight > 0
                  ? Center(
                      child: Text(
                        surah.weight.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              isActive ? Theme.of(context).primaryColor : null,
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
                      color: isActive ? Theme.of(context).primaryColor : null,
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
              SizedBox(
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
    );
  }

  bool _isActive(BuildContext context) {
    final currentSurah = BlocProvider.of<ActivePageBloc>(context).state.surah;
    return currentSurah != null && currentSurah.id == surah.id;
  }
}
