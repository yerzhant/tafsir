import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/suwar/model/surah.dart';
import 'package:tafsir/text/model/aayah.dart';
import 'package:tafsir/text/ui/aayah_player.dart';
import 'package:tafsir/text/ui/html_text.dart';

const _labelStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

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
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: <Widget>[
          Container(
            color: Color(0xffeef5f7),
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
                      color: primaryColor,
                      icon: Icon(Icons.share),
                      onPressed: _share,
                    ),
                    IconButton(
                      iconSize: iconSize,
                      icon: Icon(
                        Icons.bookmark,
                        color: _isBookmarked(context)
                            ? primaryColor
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
                          style: GoogleFonts.scheherazade(fontSize: 34),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text('ПЕРЕВОД:', style: _labelStyle),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: <Widget>[
              Expanded(child: HtmlText(text: widget.aayah.text)),
            ],
          ),
          if (widget.aayah.tafsir.isNotEmpty) SizedBox(height: 20),
          if (widget.aayah.tafsir.isNotEmpty)
            Row(
              children: <Widget>[
                Text('ТАФСИР:', style: _labelStyle),
              ],
            ),
          if (widget.aayah.tafsir.isNotEmpty) SizedBox(height: 7),
          if (widget.aayah.tafsir.isNotEmpty)
            HtmlText(text: widget.aayah.tafsir),
        ],
      ),
    );
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
