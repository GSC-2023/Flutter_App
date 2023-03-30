import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:break_app/colors/colors.dart';

class VideoApp extends StatefulWidget {
  final String type;
  VideoApp({required this.type});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  void _initVideoPlayer() async {
    final storageRef = FirebaseStorage.instance.ref();
    final videoRef = widget.type == "breathing"
        ? storageRef.child('Breathing Exercises')
        : storageRef.child('Soothing Podcasts');
    final ListResult result = await videoRef.list();
    final List<Reference> allFiles = result.items;
    List<String> files = [];
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add(fileUrl);
    });
    var rng = Random();
    int randint = rng.nextInt(5);
    _controller = VideoPlayerController.network(files[randint]);
    await _controller.initialize();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !isLoading
            ? Column(
                children: [
                  Container(
                    child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: VideoPlayer(_controller),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: _controller.value.isPlaying
                          ? Icon(
                              Icons.pause,
                              color: DarkGreen,
                            )
                          : Icon(
                              Icons.play_arrow,
                              color: DarkGreen,
                            ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(30),
                        backgroundColor: White,
                        elevation: 15,
                      ),
                    ),
                  )
                ],
              )
            : Container(
                height: 200,
                child: Center(
                  child: SpinKitFadingCircle(
                    color: LightBlue,
                    size: 75.0,
                  ),
                ),
              ),
      ],
    );
  }
}
