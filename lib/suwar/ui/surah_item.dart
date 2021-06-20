import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';

class SurahItem extends StatelessWidget {
  final Surah surah;
  final bool isActive;

  const SurahItem(
    this.surah, {
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/text/0/0/0', arguments: surah);
        Modular.get<SuwarBloc>().add(SuwarEvent.updateActiveSurah(surah));
      },
      child: Container(
        color: isActive ? const Color(0x1a0088c7) : null,
        height: 74,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              _head(context),
              const SizedBox(width: 9),
              _center(context),
              if (surah.isSurah()) _tail(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _head(BuildContext context) {
    return Container(
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
    );
  }

  Expanded _center(BuildContext context) {
    return Expanded(
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
    );
  }

  Column _tail(BuildContext context) {
    return Column(
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
    );
  }
}
