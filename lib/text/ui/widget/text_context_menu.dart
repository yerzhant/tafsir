import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tafsir/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:tafsir/bookmarks/domain/model/bookmark.dart';
import 'package:tafsir/go_to_aayah/ui/go_to_aayah_dialog.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/text/ui/text_page.dart';
import 'package:tafsir/text/ui/widget/aayah_player.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class TextContextMenu extends StatelessWidget {
  final Surah surah;

  const TextContextMenu(this.surah, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: Modular.get(),
        builder: (context, state) {
          return Container(
            color: state.toolsBackground,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            child: Column(
              children: [
                _title(context),
                const SizedBox(height: 24),
                _player(),
                const Divider(height: 27),
                _bookmark(context),
                const Divider(height: 27),
                _share(context),
                const Divider(height: 27),
                const GoToAayahDialog(),
              ],
            ),
          );
        },
      ),
    );
  }

  InkWell _share(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SelectedTextWidget>().widget?.share();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 23, left: 16),
            child: SvgPicture.asset('assets/icons/share.svg'),
          ),
          Text(
            'Поделиться',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  Widget _bookmark(BuildContext context) {
    return BlocBuilder<BookmarksBloc, BookmarksState>(
      bloc: Modular.get(),
      builder: (context, state) {
        return Consumer<SelectedTextWidget>(
          builder: (_, value, __) => InkWell(
            onTap: () => _toggleBookmark(state, value),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 23, left: 16),
                  child: SvgPicture.asset(
                    _isBookmarkedString(
                      state,
                      value,
                      'assets/icons/bookmark-filled.svg',
                      'assets/icons/bookmark.svg',
                    ),
                  ),
                ),
                Text(
                  _isBookmarkedString(
                    state,
                    value,
                    'Из закладок',
                    'В закладки',
                  ),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleBookmark(BookmarksState state, SelectedTextWidget value) {
    final bloc = Modular.get<BookmarksBloc>();

    state.maybeWhen(
      (items) {
        final bookmark = items.firstWhere(
          (b) =>
              b.surahId == surah.id && b.aayah == value.widget?.textItem.weight,
          orElse: () => Bookmark.autogenerate(
            surahId: surah.id,
            surahTitle: surah.title,
            aayah: value.widget!.textItem.weight,
          ),
        );

        if (bookmark.id == null) {
          bloc.add(BookmarksEvent.add(bookmark));
        } else {
          bloc.add(BookmarksEvent.remove(bookmark));
        }
      },
      orElse: () {},
    );
  }

  String _isBookmarkedString(
    BookmarksState state,
    SelectedTextWidget value,
    String yes,
    String no,
  ) =>
      state.maybeWhen(
        (items) => items.any((b) =>
                b.surahId == surah.id &&
                b.aayah == value.widget?.textItem.weight)
            ? yes
            : no,
        orElse: () => no,
      );

  Consumer<SelectedTextWidget> _player() {
    return Consumer<SelectedTextWidget>(
      builder: (_, value, __) {
        if (value.widget == null) {
          return Container();
        } else {
          return AayahPlayer(
            value.widget!.textItem.surahId,
            value.widget!.textItem.weight,
          );
        }
      },
    );
  }

  Consumer<SelectedTextWidget> _title(BuildContext context) {
    return Consumer<SelectedTextWidget>(
      builder: (_, value, __) {
        return Text(
          '${surah.title}: ${value.widget?.textItem.title} аят',
          style: Theme.of(context).textTheme.headline5,
        );
      },
    );
  }
}
