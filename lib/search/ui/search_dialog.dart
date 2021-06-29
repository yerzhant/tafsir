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

class SearchDialog extends StatefulWidget {
  final SearchBloc bloc;
  const SearchDialog(this.bloc, {Key? key}) : super(key: key);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  Timer? _timer;

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
    return Dialog(
      insetPadding: const EdgeInsets.all(7),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 25,
                    ),
                    border: InputBorder.none,
                    hintText: 'Введите фразу',
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
          ),
          const Divider(height: 1),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              bloc: widget.bloc,
              builder: (context, state) {
                return state.when(
                  results: (_, items) => _items(items),
                  inProgress: () => const CircularProgress(),
                  notFound: () =>
                      const Center(child: Text('Ничего не найдено.')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView _items(List<FoundItem> items) {
    return ListView.separated(
      itemBuilder: (_, i) => FoundItemWidget(items[i]),
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: items.length,
    );
  }
}
