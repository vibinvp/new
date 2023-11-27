import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:paystome/controller/videoPlayer/video_player_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/model/Order/get_orders_model.dart';
import 'package:paystome/model/Services/service_details.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String videoName;
  final String videoDescription;

  const VideoPlayerScreen(
      {super.key,
      required this.videoUrl,
      required this.videoName,
      required this.videoDescription});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

late VideoPlayController videoPlayController;

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void initState() {
    super.initState();
    videoPlayController =
        Provider.of<VideoPlayController>(context, listen: false);
    videoPlayController.isPortrait = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      videoPlayController.initializeVideo(widget.videoUrl);
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    videoPlayController.controller.setVolume(0.0);
    videoPlayController.controller.pause();
  }

  @override
  void dispose() async {
    if (videoPlayController.controller.value.isPlaying) {
      videoPlayController.controller.pause();
    }
    videoPlayController.controller.removeListener(() {});
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, VideoPlayController value, child) {
      return Scaffold(
          appBar: value.isLoading
              ? null
              : videoPlayController.isPortrait
                  ? AppBar(
                      backgroundColor: Colors.blue, // Customize the color
                      leading: IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            videoPlayController.controller.pause();
                            Navigator.pop(context);
                          }),
                      title: const Text(
                        'Video Player',
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  : null,
          body: SafeArea(
            child:
                Consumer(builder: (context, VideoPlayController value, child) {
              return value.isLoading
                  ? const Center(
                      child: LoadreWidget(),
                    )
                  : value.controller.value.isInitialized
                      ? Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      videoPlayController.isPortrait == false
                                          ? MediaQuery.of(context).size.height
                                          : 230,
                                  child: AspectRatio(
                                    aspectRatio:
                                        value.controller.value.aspectRatio,
                                    child: VideoPlayer(
                                      value.controller,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              value.videoPuseAndPlay();
                                            },
                                            child: Icon(
                                              value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: AppColoring.kAppColor,
                                              size: 32,
                                            ),
                                          ),
                                          Text(
                                            "${value.currentPosition.inMinutes}:${value.currentPosition.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${value.totalDuration.inMinutes}:${value.totalDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                            style: const TextStyle(
                                                color: AppColoring.kAppColor,
                                                fontSize: 15),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              _toggleOrientation();
                                            },
                                            child: Icon(
                                              value.isPortrait
                                                  ? Icons.fullscreen
                                                  : Icons.fullscreen_exit,
                                              size: 32,
                                              color: AppColoring.kAppColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      VideoProgressIndicator(
                                        value.controller,
                                        allowScrubbing: true,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            value.isPortrait
                                ? Expanded(
                                    child: ListView(
                                      children: [
                                        headingWiget(),
                                        shortDiscriptionWiget(),
                                        discriptionWiget(),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        )
                      : const Center(
                          child: LoadreWidget(),
                        );
            }),
          ));
    });
  }

  void _toggleOrientation() {
    setState(() {
      videoPlayController.isPortrait = !videoPlayController.isPortrait;
      if (videoPlayController.isPortrait) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    });
  }

  Widget headingWiget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10),
      child: Text(
        widget.videoName,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget shortDiscriptionWiget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Text(
        widget.videoDescription,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget discriptionWiget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          AppSpacing.ksizedBox3,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: HtmlWidget(
              widget.videoDescription,
              onErrorBuilder: (context, element, error) =>
                  Text('$element error: $error'),
              onLoadingBuilder: (context, element, loadingProgress) => SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const LoadreWidget(),
              ),

              onTapUrl: (url) {
                // launchUrl(Uri.parse(url));
                return true;
              },

              renderMode: RenderMode.column,

              // set the default styling for text
              textStyle: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
