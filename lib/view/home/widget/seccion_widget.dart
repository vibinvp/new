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
import 'package:paystome/view/VideoList/video_list_screeen.dart';
import 'package:paystome/view/videoDetails/video_details._screen.dart';
import 'package:paystome/view/videoPlayer/screen_video_player.dart';
import 'package:paystome/view/videoPlayer/screen_youtube_video.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class SingleSection extends StatelessWidget {
  final int index;
  final String sectionTitle;
  final String catId;
  final List<ProductsData> productList;

  const SingleSection({
    Key? key,
    required this.index,
    required this.productList,
    required this.sectionTitle,
    required this.catId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productList.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    hedingcaregoryList(
                      catId: catId,
                      context,
                      title: sectionTitle,
                    ),
                    SizedBox(
                      height: 260, // Set a large maximum height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          return singleSectionContainer(
                            context,
                            index: index,
                            productList: productList[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }

  Widget singleSectionContainer(context,
      {required int index, required ProductsData productList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Material(
        elevation: 10,
        shadowColor: AppColoring.primaryWhite,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Consumer(builder: (context, ServiceController service, child) {
          return InkWell(
            onTap: () {
              service
                  .isPurshasedVideo(context, pId: productList.productId ?? '')
                  .then((value) {
                if (value == false) {
                  RouteConstat.nextNamed(
                      context,
                      VideoDetailScreen(
                        serviceModel: productList,
                      ));
                } else {
                  String jsonData = productList.downloadableFiles ?? "";
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
                            videoDescription:
                                productList.productDescription ?? '',
                            videoName: productList.productName ?? '',
                          ));
                      log('true');
                    } else if (jsonList[0]['data'][0]['type'] == 'link') {
                      RouteConstat.nextNamed(
                          context,
                          YoutubeVideoScreen(
                            videoUrl: mask.toString(),
                            videoDescription:
                                productList.productDescription ?? '',
                            videoName: productList.productName ?? '',
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 10,
                        height: 160,
                        decoration: const BoxDecoration(
                          color: AppColoring.kAppColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: productList.productFeaturedImage == null
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
                                      productList.productFeaturedImage
                                          .toString()),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 4),
                            child: Text(
                              productList.productName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2),
                            child: Text(
                              productList.productShortDescription ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                            " ₹${productList.productPrice} ", // Replace with your actual price
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
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

Widget hedingcaregoryList(
  BuildContext context, {
  required String title,
  required String catId,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 15.0,
      top: 5.0,
      left: 15.0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: GestureDetector(
                child: Text(
                  'Show All',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                ),
                onTap: () {
                  RouteConstat.nextNamed(
                      context, VideoListScreen(catName: title, catId: catId));
                },
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),
      ],
    ),
  );
}
