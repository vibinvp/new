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
import 'package:paystome/view/Orders/my_videos_screen.dart';
import 'package:paystome/view/Orders/order_details.dart';
import 'package:paystome/view/videoPlayer/screen_video_player.dart';
import 'package:paystome/view/videoPlayer/screen_youtube_video.dart';
import 'package:paystome/widget/pop_up_widget.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class ScreenMyOrders extends StatefulWidget {
  const ScreenMyOrders({super.key});

  @override
  State<ScreenMyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<ScreenMyOrders> {
  late OrderController orderController;
  final ScrollController _scrollController = ScrollController();
  int countval = 0;

  @override
  void initState() {
    orderController = Provider.of<OrderController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (countval == 0) {
        orderController.getOrders(
          context,
        );
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        countval = countval + int.parse(AppConstant.perPage);
        orderController.getOrders(
          context,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColoring.kAppColor,
        leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "My Videos",
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: orderList(context),
    );
  }

  Widget orderList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Consumer(
        builder: (context, OrderController order, child) {
          return order.isLoadingGetOrder || order.orderModel == null
              ? const ShimmerEffect()
              : order.orderList.isEmpty
                  ? const Center(
                      child: Text('No Video Found!'),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      shrinkWrap: true,
                      itemCount: order.orderList.length,
                      itemBuilder: (context, index) {
                        final data = order.orderList[index];
                        return Card(
                          child: InkWell(
                            onTap: () {
                              RouteConstat.nextNamed(
                                context,
                                ScreenOrderDetails(orderData: data),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order ID:${data.txnId == null || data.txnId == '' ? data.id ?? '' : data.txnId}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '🕐 ${data.createdAt.toString()}',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  AppSpacing.ksizedBox10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.productName ?? '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      AppSpacing.ksizedBoxW5,
                                      Text(
                                        '₹${data.total}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColoring.successPopup,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}







// class ScreenMyOrders extends StatefulWidget {
//   const ScreenMyOrders({super.key});

//   @override
//   State<ScreenMyOrders> createState() => _ScreenMyVideosState();
// }

// late OrderController orderController;

// class _ScreenMyVideosState extends State<ScreenMyOrders> {
//   @override
//   void initState() {
//     orderController = Provider.of<OrderController>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       orderController.getOrders(context);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: AppColoring.kAppColor,
//         title: const Text(
//           "My Orders",
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               orderListWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget orderListWidget() {
//     return Consumer(
//       builder: (context, OrderController orderController, child) {
//         return orderController.isLoadingGetOrder
//             ? const ShimmerEffect()
//             : orderController.orderList.isEmpty
//                 ? const SizedBox(
//                     height: 600,
//                     child: Center(
//                       child: Text('No Data Found'),
//                     ),
//                   )
//                 : ListView.separated(
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: orderController.orderList.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return listWiewItenWidget(
//                           order: orderController.orderList[index]);
//                     },
//                     separatorBuilder: (context, index) =>
//                         AppSpacing.ksizedBox10,
//                   );
//       },
//     );
//   }

//   Widget listWiewItenWidget({required OrderList order}) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.94,
//       decoration: BoxDecoration(
//         boxShadow: const [
//           BoxShadow(
//             color: AppColoring.kAppColor,
//             blurRadius: 1.0,
//           ),
//         ],
//         color: AppColoring.lightBg,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: InkWell(
//         onTap: () {
//           RouteConstat.nextNamed(
//               context,
//               ScreenMyVideos(
//                 orderList: order,
//               ));
//         },
//         child: Card(
//           margin: EdgeInsets.zero,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           color: Colors.white,
//           elevation: 0,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       order.txnId == null || order.txnId == ''
//                           ? order.id ?? ''
//                           : '',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 12,
//                       ),
//                     ),
//                     Text(
//                       order.createdAt ?? '',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Card(
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Container(
//                       width: 90,
//                       height: 90,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: order.productFeaturedImage == null
//                             ? Image.asset(
//                                 Utils.setPngPath("logo"),
//                                 fit: BoxFit.fill,
//                               )
//                             : CachedNetworkImage(
//                                 errorWidget: (context, url, error) {
//                                   return const Icon(Icons.error);
//                                 },
//                                 progressIndicatorBuilder:
//                                     (context, url, downloadProgress) {
//                                   return const SingleBallnerItemSimmer();
//                                 },
//                                 fit: BoxFit.fill,
//                                 imageUrl: ApiBaseConstant.baseUrl +
//                                     AppConstant.categoryImageUrl +
//                                     order.productFeaturedImage.toString()),
//                       ),
//                     ),
//                   ),
//                   AppSpacing.ksizedBoxW5,
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           order.productName ?? '',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           '₹${order.productPrice}',
//                           style: const TextStyle(
//                               fontSize: 16,
//                               color: AppColoring.successPopup,
//                               fontWeight: FontWeight.w900),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   confirmOrderPopUp(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) =>
//           Consumer(builder: (context, OrderController value, child) {
//         return ConfirmationDialog(
//           icon: Utils.setPngPath('warning').toString(),
//           title: 'Are you sure to confirm?',
//           description: 'You want to confirm this order?',
//           onYesPressed: () {},
//         );
//       }),
//     );
//   }
// }
