import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProgressWidget extends StatefulWidget {
  final int aayaat;
  final ItemPositionsListener itemPositionsListener;

  const ProgressWidget(this.aayaat, this.itemPositionsListener);

  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  var _position = 0.0;

  @override
  void initState() {
    super.initState();

    widget.itemPositionsListener.itemPositions.addListener(() {
      if (widget.itemPositionsListener.itemPositions.value.isEmpty) return;

      setState(() {
        final item = widget.itemPositionsListener.itemPositions.value.first;
        _position = item.index / widget.aayaat;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _position,
      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    );
  }
}
