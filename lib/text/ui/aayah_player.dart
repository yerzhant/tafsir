import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:tafsir/constants.dart';

const _audioBaseUrl = '$server/upload/Quran/abu-bakr-al-shatri';

final _player = AudioPlayer();
StreamSubscription _stopListener;

class AayahPlayer extends StatefulWidget {
  final String surah;
  final String aayah;

  const AayahPlayer({Key key, this.surah, this.aayah}) : super(key: key);

  @override
  _AayahPlayerState createState() => _AayahPlayerState();
}

class _AayahPlayerState extends State<AayahPlayer> {
  var _isPlaying = false;

  String _url;

  @override
  void initState() {
    super.initState();
    _buildUrl();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      color: Theme.of(context).primaryColor,
      icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
      onPressed: _pressed,
    );
  }

  void _pressed() async {
    await _player.stop();

    if (_isPlaying) {
      _isPlaying = false;
    } else {
      await _player.play(_url);
      _isPlaying = true;

      await _stopListener?.cancel();
      _stopListener = _player.onPlayerStateChanged.listen((event) {
        if (event == AudioPlayerState.STOPPED) {
          _isPlaying = false;
          if (mounted) setState(() {});
        }
      });
    }
    setState(() {});
  }

  void _buildUrl() {
    final surah = widget.surah.padLeft(3, '0');
    final aayah = widget.aayah.padLeft(3, '0');
    _url = '$_audioBaseUrl/$surah/$surah$aayah.mp3';
  }
}
