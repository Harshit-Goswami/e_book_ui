import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  const AudioFile({super.key, required this.audioPlayer, required this.audioPath});

  final AudioPlayer audioPlayer;
  final String audioPath;

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration =  Duration();
  Duration _position = Duration();
  final String path =
      "https://firebasestorage.googleapis.com/v0/b/flutterfire-9d73f.appspot.com/o/%E2%9C%A8Radha_Radha_naam_ratat_hai%E2%9C%A8_WhatsApp_status_God_WhatsApp_status(MP3_160K)%5B1%5D.mp3?alt=media&token=97eb548a-3a32-4991-9f7e-397ea6559096";
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    widget.audioPlayer.setSourceUrl(path);
    widget.audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    widget.audioPlayer.onPlayerComplete.listen((event) {
      _position = Duration(seconds: 0);
      isPlaying = false;

    });
    super.initState();
  }

  Widget btnStart() {
    return IconButton(
      onPressed: () {
        if (isPlaying) {
          widget.audioPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        } else {
          widget.audioPlayer.play(UrlSource(path));
          setState(() {
            isPlaying = true;
          });
        }
      },
      icon: isPlaying
          ? Icon(_icons[1], size: 50, color: Colors.blue)
          : Icon(_icons[0], size: 50, color: Colors.blue),
      padding: const EdgeInsets.only(bottom: 10),
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [btnSlow(), btnStart(), btnFast()],
      ),
    );
  }

  Widget slider() {
    return Slider(
      value: _position.inSeconds.toDouble(),
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  Widget btnFast() {
    return IconButton(
        onPressed: () {
          widget.audioPlayer.setPlaybackRate(1.5);
        },
        icon: const ImageIcon(
          AssetImage('img/forward.png'),
          size: 15,
          color: Colors.black,
        ));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          widget.audioPlayer.setPlaybackRate(0.5);
        },
        icon: const ImageIcon(
          AssetImage('img/backword.png'),
          size: 15,
          color: Colors.black,
        ));
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_position.toString().split(".")[0],
                      style: TextStyle(fontSize: 16)),
                  Text(
                    _duration.toString().split(".")[0],
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
