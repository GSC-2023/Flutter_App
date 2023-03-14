import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
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
        _controller.value.isInitialized
            ? Column(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                              color: Colors.green[200],
                            )
                          : Icon(
                              Icons.play_arrow,
                              color: Colors.green[200],
                            ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(30),
                        backgroundColor: Colors.grey[500],
                      ),
                    ),
                  )
                ],
              )
            : Container(
                height: 200,
                child: Center(
                  child: SpinKitFadingCircle(
                    color: Colors.green[200],
                    size: 100.0,
                  ),
                ),
              ),
      ],
    );
  }
}
