import 'dart:io';

import 'package:share/share.dart';

Future<void> shareApp() async {
  var text = 'Тафсир Корана\n\n';

  text += Platform.isIOS
      ? 'https://apps.apple.com/app/id1542515717'
      : 'https://play.google.com/store/apps/details?id=ru.azan.tafsir';

  await Share.share(text, subject: 'Тафсир Корана');
}
