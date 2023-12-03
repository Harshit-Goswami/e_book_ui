import 'package:audioplayers/audioplayers.dart';
import 'package:e_book_app_ui/app_colors.dart' as AppColors;
import 'package:e_book_app_ui/audio_file.dart';
import 'package:flutter/material.dart';

class DetailAudioPage extends StatefulWidget {
  const DetailAudioPage({super.key, required this.bookData,required this.index});

  final List bookData;
  final int index;

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                color: AppColors.audioBlueBackground,
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.white,
                    onPressed: () {},
                  )
                ],
              )),
          Positioned(
              top: screenHeight * 0.22,
              left: 0,
              right: 0,
              height: screenHeight * 0.36,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                     Text(
                      widget.bookData[widget.index]["title"],
                      style:const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir"),
                    ),
                     Text(
                      widget.bookData[widget.index]["text"],
                      style:const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir"),
                    ),
                    AudioFile(
                      audioPlayer: _audioPlayer,audioPath:widget.bookData[widget.index]["audio"]
                    )
                  ],
                ),
              )),
          Positioned(
              top: screenHeight * 0.14,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              height: screenHeight * 0.16,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.audioGreyBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image:  DecorationImage(
                            image: AssetImage(widget.bookData[widget.index]["img"]),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
