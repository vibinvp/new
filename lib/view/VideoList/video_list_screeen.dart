import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Services/services_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/model/Services/service_details.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/videoDetails/video_details._screen.dart';
import 'package:paystome/view/videoPlayer/screen_video_player.dart';
import 'package:paystome/view/videoPlayer/screen_youtube_video.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen(
      {super.key, required this.catId, required this.catName});

  final String catId;
  final String catName;

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late ServiceController serviceController;
  final ScrollController _scrollController = ScrollController();
  int countval = 0;

  @override
  void initState() {
    serviceController = Provider.of<ServiceController>(context, listen: false);
    serviceController.videoList = [];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (countval == 0) {
        serviceController.getvideeosList(context, '0', widget.catId);
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        countval = countval + int.parse(AppConstant.perPage);
        log(countval.toString());

        if (num.parse(serviceController.homeBookings!.data.toString()) >=
            countval) {
          serviceController.getvideeosList(
              context, countval.toString(), widget.catId);
        }
      }
    });
    super.initState();
  }

  Widget showLoadingDialog(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColoring.kAppWhiteColor.withOpacity(.2),
      ),
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppColoring.primaryWhite.withOpacity(.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
              child: CircularProgressIndicator(
            color: AppColoring.blackLight,
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Consumer(
        builder: (context, ServiceController value, child) {
          return value.isLoadCheckPrchase
              ? showLoadingDialog(context)
              : const SizedBox();
        },
      ),
      appBar: AppBar(
        backgroundColor: AppColoring.kAppColor,
        leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          widget.catName,
          maxLines: 2,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Column(
          children: [
            categoryServiceWidget(),
          ],
        )),
      ),
    );
  }

  Widget categoryServiceWidget() {
    return Consumer(
      builder: (context, ServiceController service, child) {
        return service.isLoadHomeService
            ? const ShimmerEffect()
            : service.videoList.isEmpty
                ? const SizedBox(
                    height: 600,
                    child: Center(
                      child: Text('No Videos Found'),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: service.videoList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return gridViewItem(service.videoList[index], index);
                    },
                  );
      },
    );
  }

  Widget gridViewItem(ProductsData value, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: Consumer(builder: (context, ServiceController service, child) {
        return InkWell(
          onTap: () {
            service
                .isPurshasedVideo(context, pId: value.productId ?? '')
                .then((newValue) {
              if (newValue == false) {
                RouteConstat.nextNamed(
                    context,
                    VideoDetailScreen(
                      serviceModel: value,
                    ));
              } else {
                String jsonData = value.downloadableFiles ?? "";
                List<dynamic> jsonList = json.decode(jsonData);

                if (jsonList.isNotEmpty) {
                  String type = jsonList[0]['data'][0]['type'];
                  log('remslash---------->>  $type');
                  String mask = jsonList[0]['data'][0]['mask'];
                  log('mask---------->>  $mask');

                  if (jsonList[0]['data'][0]['type'] == 'video/mp4') {
                    String videoUrl = ApiBaseConstant.baseUrl +
                        AppConstant.videoUrl +
                        mask.toString();

                    log('videoUrl---------->>  $videoUrl');
                    RouteConstat.nextNamed(
                        context,
                        VideoPlayerScreen(
                          videoUrl: videoUrl,
                          videoDescription: value.productDescription ?? '',
                          videoName: value.productName ?? '',
                        ));
                    log('true');
                  } else if (jsonList[0]['data'][0]['type'] == 'link') {
                    RouteConstat.nextNamed(
                        context,
                        YoutubeVideoScreen(
                          videoUrl: mask.toString(),
                          videoDescription: value.productDescription ?? '',
                          videoName: value.productName ?? '',
                        ));
                  }
                } else {
                  showToast(
                      msg: 'Video URL not available',
                      clr: AppColoring.errorPopUp);
                }
              }
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    color: AppColoring.lightBg,
                    // blurRadius: 1.0,
                  ),
                ], borderRadius: BorderRadius.circular(10)),
                child: Card(
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: const BoxDecoration(
                          color: AppColoring.lightBg,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: value.productFeaturedImage == null
                              ? Image.asset(
                                  Utils.setPngPath('logo'),
                                  fit: BoxFit.fill,
                                )
                              : CachedNetworkImage(
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) {
                                    return const SingleBallnerItemSimmer();
                                  },
                                  fit: BoxFit.fill,
                                  imageUrl: ApiBaseConstant.baseUrl +
                                      AppConstant.categoryImageUrl +
                                      value.productFeaturedImage.toString()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.productName ?? '',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            AppSpacing.ksizedBox15,
                            Text(
                              value.productShortDescription ?? '',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),

                            // Text(
                            //   value.productDescription ?? '',
                            //   style: TextStyle(
                            //       fontSize: 12, fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                // Positioned widget for the price badge
                top: -20, // Adjust top position as needed
                right: 0, // Adjust left position as needed
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    // color: Colors.green, // Background color of the badge
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage(
                          Utils.setPngPath('bagde'),
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 2),
                      child: FittedBox(
                        child: Text(
                          " ₹${value.productPrice}", // Replace with your actual price
                          style: const TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget addToCartOrBuyNowButton() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.blue, // Container background color
        //   borderRadius: BorderRadius.circular(25), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customButton(text: 'Add to Cart', color: AppColoring.textRed),
          // SizedBox(
          //   width: 20,
          //   height: double.infinity,
          //   child: CustomPaint(
          //     painter:
          //         DiagonalDivider(AppColoring.textRed, AppColoring.kAppColor),
          //   ),
          // ),
          customButton(text: 'Buy Now', color: AppColoring.kAppColor),
        ],
      ),
    );
  }

  Widget customButton({required String text, Color? color}) {
    return Expanded(
        child: ClipPath(
      clipper: DiagonalClipper(), // Use a custom clipper
      child: Container(
        color: Colors.white, // Color of the diagonal portion

        child: Container(
          color: color, // Background color of the button
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold, // Text weight
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, size.height); // Start at the top-right corner
    path.lineTo(size.width, size.height); // Line to the bottom-right corner
    path.lineTo(0, size.height - size.height); // Line to create the diagonal
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
