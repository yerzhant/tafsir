import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/common/ui/widget/rejection_widget.dart';
import 'package:tafsir/offline/bloc/offline_bloc.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<OfflineBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Загрузка...')),
      body: BlocBuilder<OfflineBloc, OfflineState>(
        bloc: bloc,
        builder: (context, state) {
          return state.when(
            (progress) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress / 100,
                    backgroundColor: const Color(0x1a0088c7),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${progress.toStringAsFixed(2)} %',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            error: (rejection) => RejectionWidget(
              rejection: rejection,
              onRefresh: () => bloc.add(const OfflineEvent.download()),
            ),
          );
        },
      ),
    );
  }
}
