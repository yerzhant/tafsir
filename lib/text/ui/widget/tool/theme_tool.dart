import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tafsir/common/ui/ui_constants.dart';

class ThemeTool extends StatelessWidget {
  const ThemeTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: _Buttons(),
          ),
          const Divider(
            height: 1,
            color: grey30ColorLight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Не выключать экран',
                style: Theme.of(context).textTheme.headline6,
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Тема',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Button(
              'Светлая',
              onTap: () {},
            ),
            const SizedBox(width: 10),
            _Button(
              'Тёмная',
              isBlack: true,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final bool isBlack;
  final GestureTapCallback onTap;

  const _Button(
    this.text, {
    Key? key,
    this.isBlack = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isBlack ? black2ColorLight : null,
            border: !isBlack
                ? Border.all(color: primaryColorLight, width: 2)
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: isBlack ? const Color(0x7fffffff) : black3ColorLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
