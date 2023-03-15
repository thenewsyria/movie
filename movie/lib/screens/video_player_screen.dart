class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Chewie(
          controller: ChewieController(
            videoPlayerController:
                VideoPlayerController.network(videoUrl),
            autoPlay: true,
            looping: false,
            showControls: true,
            allowMuting: true,
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.red,
              handleColor: Colors.red,
              backgroundColor: Colors.grey[800]!,
              bufferedColor: Colors.grey[600]!,
            ),
            placeholder: Container(
              color: Colors.grey[800],
            ),
            autoInitialize: true,
          ),
        ),
      ),
    );
  }
}
