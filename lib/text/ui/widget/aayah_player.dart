import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tafsir/common/ds/api.dart';

const _audioBaseUrl = '$server/upload/Quran/abu-bakr-al-shatri';

class AayahPlayer extends StatefulWidget {
  final int surah;
  final int aayah;

  const AayahPlayer(this.surah, this.aayah, {Key? key}) : super(key: key);

  @override
  _AayahPlayerState createState() => _AayahPlayerState();
}

class _AayahPlayerState extends State<AayahPlayer> {
  final _player = AudioPlayer();
  var _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pressed,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 16),
            child: _isPlaying
                ? SvgPicture.asset('assets/icons/playing.svg')
                : SvgPicture.asset('assets/icons/play.svg'),
          ),
          Text(
            _isPlaying ? 'Остановить' : 'Воспроизвести',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  void _pressed() {
    setState(() {
      if (_isPlaying) {
        _isPlaying = false;
        _player.stop();
      } else {
        _isPlaying = true;
        _setUrl();
        _player.play();
      }
    });
  }

  Future<void> _setUrl() async {
    final surah = widget.surah.toString().padLeft(3, '0');
    final aayah = widget.aayah.toString().padLeft(3, '0');
    final url = '$_audioBaseUrl/$surah/$surah$aayah.mp3';
    await _player.setUrl(url);
  }
}
