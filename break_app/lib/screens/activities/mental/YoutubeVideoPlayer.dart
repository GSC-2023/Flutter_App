// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeWidget extends StatefulWidget {
//   const YoutubeWidget({super.key});

//   @override
//   State<YoutubeWidget> createState() => _YoutubeWidgetState();
// }

// class _YoutubeWidgetState extends State<YoutubeWidget> {
//   late YoutubePlayerController _controller;
//   final videoId = YoutubePlayer.convertUrlToId(
//       "https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley");

//   @override
//   void initState() {
//     _controller = YoutubePlayerController(
//       initialVideoId: videoId!,
//       flags: YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//       onReady: () {
//         print('Player is ready.');
//       },
//     );
//   }
// }
