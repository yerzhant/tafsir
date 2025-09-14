import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tafsir/common/ui/widget/circular_progress.dart';
import 'package:tafsir/search/bloc/search_bloc.dart';
import 'package:tafsir/search/model/found_item.dart';
import 'package:tafsir/search/ui/found_item_widget.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class SearchDialog extends StatefulWidget {
  final SearchBloc bloc;

  const SearchDialog(this.bloc, {Key? key}) : super(key: key);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final _phraseController = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _phraseController.text = Modular.get<SearchBloc>().state.maybeWhen(
          results: (phrase, _) => phrase,
          orElse: () => '',
        );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _find(String phrase) {
    if (_timer?.isActive ?? false) _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 500), () {
      widget.bloc.add(SearchEvent.find(phrase));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: Modular.get(),
      builder: (context, theme) {
        return Dialog(
          backgroundColor: theme.toolsBackground,
          insetPadding: const EdgeInsets.all(7),
          child: Column(
            children: [
              _searchField(context),
              const Divider(height: 1),
              _results(),
            ],
          ),
        );
      },
    );
  }

  Expanded _results() {
    return Expanded(
      child: BlocBuilder<SearchBloc, SearchState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return state.when(
            results: (phrase, items) => _items(phrase, items),
            inProgress: () => const CircularProgress(),
            notFound: () => Center(
                child: Text(
              'Ничего не найдено.',
              style: Theme.of(context).textTheme.titleMedium,
            )),
          );
        },
      ),
    );
  }

  Row _searchField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _phraseController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              border: InputBorder.none,
              hintText: 'Введите фразу',
            ),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            onChanged: _find,
          ),
        ),
        IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: SvgPicture.asset('assets/icons/close.svg'),
        ),
      ],
    );
  }

  ListView _items(String phrase, List<FoundItem> items) {
    return ListView.separated(
      itemBuilder: (_, i) => FoundItemWidget(phrase, items[i]),
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: items.length,
    );
  }
}
