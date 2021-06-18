import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/theme/cubit/theme_cubit.dart';

class FontSizeTool extends StatelessWidget {
  const FontSizeTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: const [
          _FontSize('Коран'),
          Divider(height: 1),
          _FontSize('Перевод'),
          Divider(height: 1),
          _FontSize('Тафсир'),
        ],
      ),
    );
  }
}

class _FontSize extends StatelessWidget {
  final String label;

  const _FontSize(
    this.label, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          label,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        Slider(
          min: 5,
          max: 30,
          value: 10,
          onChanged: (value) {},
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
