import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingImage(),
    );
  }
}

class LoadingImage extends StatelessWidget {
  const LoadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image in fade'),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    width: 200,
                    height: 200,
                    child: FadeInImage.memoryNetwork(
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Text('not loaded.');
                        },
                        placeholder: kTransparentImage,
                        image: 'https://picsum.photos/250?image=9')),
              ],
            ),
            const VideoPlayerTest(),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerTest extends StatefulWidget {
  const VideoPlayerTest({super.key});

  @override
  State<VideoPlayerTest> createState() => _VideoPlayerTestState();
}

class _VideoPlayerTestState extends State<VideoPlayerTest> {
  late VideoPlayerController _vpController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _vpController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );
    _initializeVideoPlayerFuture = _vpController.initialize();
  }

  @override
  void dispose() {
    _vpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _vpController.value.aspectRatio,
                    child: VideoPlayer(_vpController),
                  );
                } else {
                  return const CircularProgressIndicator.adaptive();
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (_vpController.value.isPlaying) {
                  _vpController.pause();
                } else {
                  _vpController.play();
                }
              });
            },
            child: Icon(
              _vpController.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }
}
