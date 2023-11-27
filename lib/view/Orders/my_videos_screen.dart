import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/orders/order_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/model/Order/get_orders_model.dart';
import 'package:paystome/model/Services/service_details.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/videoPlayer/screen_video_player.dart';
import 'package:paystome/view/videoPlayer/screen_youtube_video.dart';
import 'package:paystome/widget/pop_up_widget.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class ScreenMyVideos extends StatefulWidget {
  const ScreenMyVideos({super.key, required this.orderList});
  final OrderList orderList;

  @override
  State<ScreenMyVideos> createState() => _ScreenMyVideosState();
}

late OrderController orderController;

class _ScreenMyVideosState extends State<ScreenMyVideos> {
  @override
  void initState() {
    orderController = Provider.of<OrderController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      orderController.getOrders(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          "My Videos",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              listWiewItenWidget(order: widget.orderList),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderListWidget() {
    return Consumer(
      builder: (context, OrderController orderController, child) {
        return orderController.isLoadingGetOrder
            ? const ShimmerEffect()
            : orderController.orderList.isEmpty
                ? const SizedBox(
                    height: 600,
                    child: Center(
                      child: Text('No Data Found'),
                    ),
                  )
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderController.orderList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return listWiewItenWidget(
                          order: orderController.orderList[index]);
                    },
                    separatorBuilder: (context, index) =>
                        AppSpacing.ksizedBox10,
                  );
      },
    );
  }

  Widget listWiewItenWidget({required OrderList order}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: AppColoring.kAppColor,
            blurRadius: 1.0,
          ),
        ],
        color: AppColoring.lightBg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          String jsonData = order.downloadableFiles ?? "";
          List<dynamic> jsonList = json.decode(jsonData);
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
                  videoDescription: order.productDescription ?? '',
                  videoName: order.productName ?? '',
                ));
            log('true');
          } else if (jsonList[0]['data'][0]['type'] == 'link') {
            RouteConstat.nextNamed(
                context,
                YoutubeVideoScreen(
                  videoUrl: mask.toString(),
                  videoDescription: order.productDescription ?? '',
                  videoName: order.productName ?? '',
                ));
          }
        },
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.white,
          elevation: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: order.productFeaturedImage == null
                        ? Image.asset(
                            Utils.setPngPath("logo"),
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
                                order.productFeaturedImage.toString()),
                  ),
                ),
              ),
              AppSpacing.ksizedBoxW5,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      order.productName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      order.productShortDescription ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    // Text(
                    //   '₹${order.productPrice}',
                    //   style: const TextStyle(
                    //       fontSize: 16,
                    //       color: AppColoring.successPopup,
                    //       fontWeight: FontWeight.w900),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirmOrderPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          Consumer(builder: (context, OrderController value, child) {
        return ConfirmationDialog(
          icon: Utils.setPngPath('warning').toString(),
          title: 'Are you sure to confirm?',
          description: 'You want to confirm this order?',
          onYesPressed: () {},
        );
      }),
    );
  }
}
