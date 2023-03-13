//In this code, we create a TrailerDialog widget that displays a dialog with a YouTube video player.
// We use the YoutubePlayerController from the youtube_player_flutter package to play the video.
// We pass the video key for the movie to the controller

import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerDialog extends StatefulWidget {
  final Movie movie;

  const TrailerDialog({Key? key, required this.movie}) : super(key: key);

  @override
  _TrailerDialogState createState() => _TrailerDialogState();
}

class _TrailerDialogState extends State<TrailerDialog> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movie.videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: YoutubePlayer(
        controller: _controller,
        liveUIColor: Colors.amber,
      ),
      actions: [
        TextButton(
          onPressed: () {
            _controller.pause();
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
