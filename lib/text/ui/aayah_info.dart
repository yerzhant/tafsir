import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:tafsir/bloc/theme_bloc.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/bloc/settings_bloc.dart';
import 'package:tafsir/text/model/aayah.dart';
import 'package:tafsir/text/ui/aayah_player.dart';
import 'package:tafsir/text/ui/html_text.dart';

class AayahInfo extends StatefulWidget {
  final Surah surah;
  final Aayah aayah;

  const AayahInfo({Key key, this.surah, this.aayah}) : super(key: key);

  @override
  _AayahInfoState createState() => _AayahInfoState();
}

class _AayahInfoState extends State<AayahInfo> {
  @override
  Widget build(BuildContext context) {
    final themeState = BlocProvider.of<ThemeBloc>(context).state;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final _labelStyle = TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: state.fontSize,
          );

          return Column(
            children: <Widget>[
              _aayah(context, state, themeState),
              if (state.showTranslation) ..._translation(_labelStyle),
              if (state.showTafsir && widget.aayah.tafsir.isNotEmpty)
                ..._tafsir(_labelStyle),
            ],
          );
        },
      ),
    );
  }

  Material _aayah(
    BuildContext context,
    SettingsState settingsState,
    ThemeState themeState,
  ) {
    return Material(
      color: themeState.aayahBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AayahPlayer(
                  key: Key(
                    '${widget.aayah.surahId}:${widget.aayah.weight}',
                  ),
                  surah: widget.aayah.surahId.toString(),
                  aayah: widget.aayah.weight.toString(),
                ),
                SizedBox(width: 45),
                Spacer(),
                Text(
                  '﴾ ',
                  style: GoogleFonts.scheherazade(fontSize: 22),
                ),
                Text(
                  widget.aayah.title,
                  style: GoogleFonts.fondamento(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' ﴿',
                  style: GoogleFonts.scheherazade(fontSize: 22),
                ),
                Spacer(),
                IconButton(
                  iconSize: iconSize,
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.share),
                  onPressed: _share,
                ),
                IconButton(
                  iconSize: iconSize,
                  icon: Icon(
                    Icons.bookmark,
                    color: _isBookmarked(context)
                        ? Theme.of(context).primaryColor
                        : textColorGrey,
                  ),
                  onPressed: () => _toggleBookmark(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.aayah.textOrigin.trim(),
                      style: GoogleFonts.scheherazade(
                        fontSize: settingsState.aayahFontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _translation(TextStyle labelStyle) {
    return [
      SizedBox(height: 20),
      Row(
        children: <Widget>[
          Text('ПЕРЕВОД:', style: labelStyle),
        ],
      ),
      SizedBox(height: 7),
      Row(
        children: <Widget>[
          Expanded(child: HtmlText(text: widget.aayah.text)),
        ],
      ),
    ];
  }

  List<Widget> _tafsir(TextStyle labelStyle) {
    return [
      SizedBox(height: 20),
      Row(
        children: <Widget>[
          Text('ТАФСИР:', style: labelStyle),
        ],
      ),
      SizedBox(height: 7),
      HtmlText(text: widget.aayah.tafsir),
    ];
  }

  void _toggleBookmark(BuildContext context) async {
    final bookmarkRepository =
        RepositoryProvider.of<TafsirRepository>(context).bookmarkRepository;
    final state =
        BlocProvider.of<ActivePageBloc>(context).state as ActivePageText;

    if (_isBookmarked(context)) {
      final bookmark = state.bookmarks
          .singleWhere((element) => element.aayah == widget.aayah.weight);
      await bookmarkRepository.delete(bookmark);
      state.bookmarks.remove(bookmark);
    } else {
      final bookmark = await bookmarkRepository.insert(
        Bookmark.autogenerate(
          surahId: state.surah.id,
          surahTitle: state.surah.title,
          aayah: widget.aayah.weight,
        ),
      );
      state.bookmarks.add(bookmark);
    }
    setState(() {});
  }

  bool _isBookmarked(BuildContext context) {
    final state =
        BlocProvider.of<ActivePageBloc>(context).state as ActivePageText;
    return state.bookmarks.any(
      (element) => element.aayah == widget.aayah.weight,
    );
  }

  void _share() {
    final subject = '${widget.surah.title}, ${widget.aayah.weight}';
    var text = '$subject.\n';
    text += '\n';

    text += '${widget.aayah.textOrigin}\n\n';

    text += 'ПЕРЕВОД:\n';
    text += _htmlToString(widget.aayah.text);

    if (widget.aayah.tafsir != '') {
      text += '\n\n';
      text += 'ТАФСИР:\n';
      text += _htmlToString(widget.aayah.tafsir);
    }

    Share.share(text, subject: subject);
  }

  String _htmlToString(String html) {
    final doc = parse(html);
    return parse(doc.body.text).documentElement.text.trim();
  }
}
