import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ui/widget/circular_progress.dart';
import 'package:tafsir/common/ui/widget/rejection_widget.dart';
import 'package:tafsir/suwar/bloc/suwar_bloc.dart';
import 'package:tafsir/suwar/domain/model/surah.dart';
import 'package:tafsir/suwar/ui/surah_item.dart';

class SuwarList extends StatelessWidget {
  const SuwarList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<SuwarBloc>();

    return BlocBuilder<SuwarBloc, SuwarState>(
      bloc: bloc,
      builder: (context, state) => state.when(
        (suwar, active) => _buildList(suwar, active),
        inProgress: () => const CircularProgress(),
        error: (rejection) => RejectionWidget(
          rejection: rejection,
          onRefresh: () => bloc.add(const SuwarEvent.load()),
        ),
      ),
    );
  }

  Widget _buildList(List<Surah> suwar, Surah? active) {
    return ListView.separated(
      key: const PageStorageKey('suwar-list'),
      itemCount: suwar.length,
      itemBuilder: (_, index) => SurahItem(
        suwar[index],
        isActive: suwar[index].id == active?.id,
      ),
      separatorBuilder: (_, __) => const Divider(height: 1),
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
