import 'package:flutter/material.dart';
import 'package:tafsir/common/domain/model/rejection.dart';
import 'package:tafsir/common/ui/ui_constants.dart';

class RejectionWidget extends StatelessWidget {
  final Rejection rejection;
  final VoidCallback onRefresh;

  const RejectionWidget({
    Key? key,
    required this.rejection,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(basePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ой, шо-то пошло не так!',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: interElementMargin),
            Text(rejection.message),
            const SizedBox(height: interElementMargin),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.repeat),
              label: const Text('ПОВТОРИТЬ'),
            ),
          ],
        ),
      ),
    );
  }
}
