import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/common/ui/widget/circular_progress.dart';
import 'package:tafsir/common/ui/widget/rejection_widget.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/suwar/ui/surah_item.dart';

class SuwarList extends StatelessWidget {
  final SuwarBloc bloc;

  const SuwarList({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuwarBloc, SuwarState>(
      bloc: bloc,
      builder: (context, state) {
        return state.when(
          (suwar) => _buildList(suwar),
          inProgress: () => const CircularProgress(),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () {},
          ),
        );
      },
    );
  }

  Widget _buildList(List<Surah> suwar) {
    return ListView.separated(
      key: const PageStorageKey('suwar-list'),
      itemCount: suwar.length,
      itemBuilder: (_, index) => SurahItem(suwar[index]),
      separatorBuilder: (_, __) => const Divider(height: 1),
    );
  }
}
