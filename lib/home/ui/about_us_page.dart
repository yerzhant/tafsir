import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/global_functions.dart';
import 'package:tafsir/common/ui/ui_constants.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О нас')),
      body: Column(
        children: [
          Image.asset('assets/images/tafsir.png'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cпециальный проект',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(width: 10),
                Image.asset('assets/images/logo-blue.png', height: 38),
              ],
            ),
          ),
          const _Action(
            title: 'Поделиться с друзьями',
            icon: 'share',
            action: shareApp,
          ),
          const SizedBox(height: 8),
          const _Action(
            title: 'Оценить приложение',
            icon: 'evaluate',
            action: evaluateApp,
          ),
          const SizedBox(height: 8),
          const _Action(
            title: 'Предложения и замечания',
            icon: 'proposals',
            action: writeToAdmin,
          ),
          const SizedBox(height: 8),
          _Action(
            title: 'Другие приложения',
            icon: 'apps',
            action: () {
              launch(
                Platform.isIOS
                    ? 'https://apps.apple.com/us/developer/id1481811874'
                    : 'https://play.google.com/store/apps/collection/cluster?clp=igMzChkKEzYzNzg4ODYzODQ2MDYxODU3NDkQCBgDEhQKDnJ1LmF6YW4udGFmc2lyEAEYAxgB:S:ANO1ljJDX40&gsr=CjaKAzMKGQoTNjM3ODg4NjM4NDYwNjE4NTc0ORAIGAMSFAoOcnUuYXphbi50YWZzaXIQARgDGAE%3D:S:ANO1ljLOIxI',
              );
            },
          ),
          const SizedBox(height: 10),
          const Divider(indent: 8, endIndent: 8, height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _Icon('web', 'https://azan.ru'),
              SizedBox(width: 21),
              _Icon('fb', 'https://www.facebook.com/azan.ru'),
              SizedBox(width: 21),
              _Icon('telegram', 'https://t.me/azan_ru'),
              SizedBox(width: 21),
              _Icon('insta', 'https://www.instagram.com/azan_ru'),
            ],
          ),
          const Spacer(),
          Container(
            height: 50,
            width: double.infinity,
            color: primaryColor,
            child: const Center(
              child: Text('НЕ ЗАБЫВАЙТЕ НАС В СВОИХ ДУА!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final String icon;
  final String url;

  const _Icon(this.icon, this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launch(url);
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return SvgPicture.asset(
            'assets/icons/about-us/$icon.svg',
            color: state.listItemNumberBox,
          );
        },
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final String title;
  final String icon;
  final Function() action;

  const _Action({
    required this.title,
    required this.icon,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return InkWell(
            onTap: action,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: state.divider),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 32),
                  SvgPicture.asset('assets/icons/about-us/$icon.svg'),
                  const SizedBox(width: 40),
                  Text(title, style: Theme.of(context).textTheme.headline4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
