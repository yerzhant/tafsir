import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tafsir/settings/bloc/settings_bloc.dart';

class FontSizeTool extends StatelessWidget {
  const FontSizeTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Modular.get<SettingsBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: settings,
        builder: (context, state) {
          return Column(
            children: [
              _FontSize(
                'Коран',
                min: 30,
                max: 60,
                size: state.aayahFontSize,
                onChanged: (size) => settings.add(
                  SettingsEvent.setAayahFontSize(size),
                ),
              ),
              const Divider(height: 1),
              _FontSize(
                'Перевод',
                min: 14,
                max: 30,
                size: state.textFontSize,
                onChanged: (size) => settings.add(
                  SettingsEvent.setTextFontSize(size),
                ),
              ),
              const Divider(height: 1),
              _FontSize(
                'Тафсир',
                min: 14,
                max: 30,
                size: state.tafsirFontSize,
                onChanged: (size) => settings.add(
                  SettingsEvent.setTafsirFontSize(size),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FontSize extends StatefulWidget {
  final String label;
  final double size;
  final double min;
  final double max;
  final void Function(double size) onChanged;

  const _FontSize(
    this.label, {
    Key? key,
    required this.size,
    required this.min,
    required this.max,
    required this.onChanged,
  }) : super(key: key);

  @override
  __FontSizeState createState() => __FontSizeState();
}

class __FontSizeState extends State<_FontSize> {
  late double _size = widget.size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 8),
        Slider(
          min: widget.min,
          max: widget.max,
          value: _size,
          onChangeEnd: widget.onChanged,
          onChanged: (size) {
            setState(() {
              _size = size;
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
