import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Dasboard/dashboard_controller.dart';
import 'package:paystome/controller/Services/services_controller.dart';
import 'package:paystome/controller/home/home_controller.dart';
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

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

late HomeController homeController;

class _ScreenSearchState extends State<ScreenSearch> {
  @override
  void initState() {
    homeController = Provider.of<HomeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.searchServices(context, '');
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
      backgroundColor: AppColoring.kAppWhiteColor,
      //key: _key,
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColoring.kAppColor,
              // leadingWidth: 15,
              leading: IconButton(
                onPressed: () {
                  RouteConstat.back(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColoring.kAppWhiteColor,
                ),
              ),
              title: const Text(
                'Search Your Videos',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColoring.kAppWhiteColor),
              ),
              centerTitle: true,

              bottom: AppBar(
                backgroundColor: AppColoring.kAppColor,
                toolbarHeight: 80,
                elevation: 0,
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                title: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      child: Consumer(
                          builder: (context, HomeController home, child) {
                        return TextField(
                          onChanged: (searchText) {
                            home.searchServices(context, searchText);
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "Search your video",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColoring.textDim),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black.withOpacity(.5),
                              )),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              ///////////////////////////////////////
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: categoryServiceWidget(),
                  );
                },
                childCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryServiceWidget() {
    return Consumer(
      builder: (context, HomeController service, child) {
        return service.isLoadingSearch
            ? const ShimmerEffect()
            : service.searchList.isEmpty
                ? const SizedBox(
                    height: 600,
                    child: Center(
                      child: Text('No Videos Found'),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: service.searchList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return gridViewItem(service.searchList[index], index);
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
}
