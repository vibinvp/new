import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoScreen extends StatefulWidget {
  final String videoUrl;
  final String videoName;
  final String videoDescription;

  const YoutubeVideoScreen({
    Key? key,
    required this.videoUrl,
    required this.videoName,
    required this.videoDescription,
  }) : super(key: key);

  @override
  State<YoutubeVideoScreen> createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  willpopFn() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      RouteConstat.back(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    return WillPopScope(
      onWillPop: () => willpopFn(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MediaQuery.of(context).size.height
                      : 230,
                  child: YoutubePlayer(
                    onEnded: (metaData) {
                      RouteConstat.back(context);
                    },

                    progressColors: const ProgressBarColors(
                      backgroundColor: AppColoring.errorPopUp,
                    ),
                    controller: YoutubePlayerController(
                      initialVideoId: videoId ?? '',
                      flags: const YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                        isLive: false,
                      ),
                    ),
                    onReady: () {},

                    showVideoProgressIndicator: true,
                    progressIndicatorColor: AppColoring.kAppWhiteColor,
                    //)
                  ),
                ),
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? const SizedBox()
                    : Expanded(
                        child: ListView(
                          children: [
                            headingWiget(),
                            discriptionWiget(),
                          ],
                        ),
                      ),
              ],
            );
          }),
        ),
      ),
    );
  }

  bool isPortrait() {
    return MediaQuery.of(context).orientation == Orientation.portrait;
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
