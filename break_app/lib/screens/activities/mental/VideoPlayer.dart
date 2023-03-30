import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:break_app/colors/colors.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  void _initVideoPlayer() async {
    final storageRef = FirebaseStorage.instance.ref();
    final breathingRef = storageRef.child('Breathing Exercises');
    final ListResult result = await breathingRef.list();
    final List<Reference> allFiles = result.items;
    List<Map<String, dynamic>> files = [];
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "url": fileUrl, //to pull image from firebase storage
      });
    });
    _controller = VideoPlayerController.network(files[0]['url']);
    await _controller.initialize();
    setState(() {});
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
        _controller.value.isInitialized
            ? Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     shape: BoxShape.rectangle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.shade400,
                    //         offset: Offset(0, 5.0),
                    //         blurRadius: 20.0
                    //       )
                    //     ]
                    //   ),
                    child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // child: VideoPlayer(_controller),
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
                    color: DarkGreen,
                    size: 100.0,
                  ),
                ),
              ),
      ],
    );
  }
}
