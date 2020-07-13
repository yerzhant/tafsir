import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tafsir/bookmarks/model/bookmark.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/repository/tafsir_repository.dart';
import 'package:tafsir/text/model/aayah.dart';
import 'package:tafsir/text/ui/html_text.dart';

class AayahInfo extends StatefulWidget {
  final Aayah aayah;

  const AayahInfo({Key key, this.aayah}) : super(key: key);

  @override
  _AayahInfoState createState() => _AayahInfoState();
}

class _AayahInfoState extends State<AayahInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: padding,
        top: 5,
        bottom: padding,
        left: padding,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 40),
              Spacer(),
              Text(
                '﴾ ',
                style: GoogleFonts.scheherazade(
                  fontSize: 25,
                ),
              ),
              Text(
                widget.aayah.title,
                style: GoogleFonts.fondamento(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' ﴿',
                style: GoogleFonts.scheherazade(
                  fontSize: 25,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: _isBookmarked(context) ? primaryColor : Colors.grey,
                ),
                onPressed: () => _toggleBookmark(context),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            color: Color(0xffeef5f7),
            padding: EdgeInsets.all(15),
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
                Text('ТАФСИР (Толкование):', style: _labelStyle),
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
}

const _labelStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
);
