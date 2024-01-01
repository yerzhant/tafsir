import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> shareApp() async {
  var text = 'Тафсир Корана\n\n';

  text += Platform.isIOS
      ? 'https://apps.apple.com/app/id1542515717'
      : 'https://play.google.com/store/apps/details?id=ru.azan.tafsir';

  await Share.share(text, subject: 'Тафсир Корана');
}

Future<void> evaluateApp() async => launch(
      Platform.isIOS
          ? 'https://apps.apple.com/us/app/id1542515717'
          : 'https://play.google.com/store/apps/details?id=ru.azan.tafsir',
    );

Future<void> writeToAdmin() async =>
    launch('https://azan.ru/site/write-to-admin');
