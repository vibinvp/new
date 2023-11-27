import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:paystome/controller/orders/order_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/model/Order/get_orders_model.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/videoPlayer/screen_video_player.dart';
import 'package:paystome/view/videoPlayer/screen_youtube_video.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/row_two_item.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class ScreenOrderDetails extends StatefulWidget {
  const ScreenOrderDetails({super.key, required this.orderData});
  final OrderList orderData;

  @override
  State<ScreenOrderDetails> createState() => _ScreenOrderDetailsState();
}

late OrderController orderController;

class _ScreenOrderDetailsState extends State<ScreenOrderDetails> {
  @override
  void initState() {
    orderController = Provider.of<OrderController>(context, listen: false);
    orderController.isDownloadInvoice = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: AppColoring.kAppWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColoring.kAppBlueColor,
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTwoItemWidget(
                    text1: 'Total Amount:',
                    text2: '₹${widget.orderData.total}',
                    fontWeight1: FontWeight.bold,
                    fontWeight2: FontWeight.bold,
                    fontSize1: 16,
                    fontSize2: 18,
                    color2: AppColoring.successPopup,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (context, OrderController value, child) {
                        return value.isDownloadInvoice
                            ? const Center(
                                child: LoadreWidget(),
                              )
                            : SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                  ),
                                  onPressed: () {
                                    value.generateAndDownloadPDF(
                                        widget.orderData.id ?? '', context);
                                  },
                                  child: Center(
                                    child: Text(
                                      'Print Invoice',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppColoring.kAppColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            //fontFamily: 'ubuntu',
                                          ),
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                  AppSpacing.ksizedBoxW15,
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: AppColoring.kAppColor,
                        ),
                        onPressed: () {
                          String jsonData =
                              widget.orderData.downloadableFiles ?? "";
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
                                  videoDescription:
                                      widget.orderData.productDescription ?? '',
                                  videoName: widget.orderData.productName ?? '',
                                ));
                            log('true');
                          } else if (jsonList[0]['data'][0]['type'] == 'link') {
                            RouteConstat.nextNamed(
                                context,
                                YoutubeVideoScreen(
                                  videoUrl: mask.toString(),
                                  videoDescription:
                                      widget.orderData.productDescription ?? '',
                                  videoName: widget.orderData.productName ?? '',
                                ));
                          }
                        },
                        child: Center(
                          child: Text(
                            'Play',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColoring.kAppWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: 'ubuntu',
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer(
          builder: (context, OrderController value, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppSpacing.ksizedBox10,
                  // orderData.orderStatusId == '0'
                  //     ? const Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           _StepChip(label: 'Pending', isActive: true),
                  //           _StepChip(label: 'Accepted', isActive: false),
                  //           _StepChip(label: 'Completed', isActive: false),
                  //         ],
                  //       )
                  //     : orderData.orderStatusId == '1'
                  //         ? const Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               _StepChip(label: 'Pending', isActive: true),
                  //               _StepChip(label: 'Accepted', isActive: true),
                  //               _StepChip(label: 'Completed', isActive: false),
                  //             ],
                  //           )
                  //         : const Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               _StepChip(label: 'Pending', isActive: true),
                  //               _StepChip(label: 'Accepted', isActive: true),
                  //               _StepChip(label: 'Completed', isActive: true),
                  //             ],
                  //           ),
                  // const Divider(
                  //   thickness: 1,
                  // ),
                  // Stepper(
                  //   currentStep: value.currentStep,
                  //   steps: value.steps,
                  //   onStepContinue: () {
                  //     // setState(() {
                  //     //   if (value.currentStep < value.steps.length - 1) {
                  //     //     value.currentStep++;
                  //     //   }
                  //     // });
                  //   },
                  //   onStepCancel: () {
                  //     // setState(() {
                  //     //   if (value.currentStep > 0) {
                  //     //     value.currentStep--;
                  //     //   }
                  //     // });
                  //   },
                  // ),
                  RowTwoItemWidget(
                    text1:
                        'Order Id:${widget.orderData.txnId == null || widget.orderData.txnId == '' ? widget.orderData.id ?? '' : widget.orderData.txnId}',
                    text2: '🕐 ${widget.orderData.createdAt}',
                    fontSize1: 14,
                    fontSize2: 14,
                  ),
                  RowTwoItemWidget(
                    text1: 'Pay Type:',
                    fontWeight1: FontWeight.bold,
                    fontSize1: 16,
                    text2: widget.orderData.paymentMode ?? '',
                    color2: AppColoring.errorPopUp,
                  ),

                  const Divider(thickness: .8),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                    child: Text(
                      'Customer Details',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    color: AppColoring.lightBg.withOpacity(.2),
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.orderData.username ?? '',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Mob.${widget.orderData.phone}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              widget.orderData.address1 ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // TextButton.icon(
                        //   onPressed: () {},
                        //   icon: const Icon(Icons.directions),
                        //   label: const Text('Direction'),
                        // ),
                        // TextButton.icon(
                        //   onPressed: () {},
                        //   icon: const Icon(Icons.directions),
                        //   label: const Text('Direction'),
                        // ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                    child: Text(
                      'Ordered Video',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          leading: Container(
                            height: 100,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(ApiBaseConstant.baseUrl +
                                      AppConstant.categoryImageUrl +
                                      widget.orderData.productFeaturedImage
                                          .toString()),
                                  fit: BoxFit.fill),
                            ),
                            child: widget.orderData.productFeaturedImage == null
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
                                        widget.orderData.productFeaturedImage
                                            .toString()),
                          ),
                          title: Text(
                            widget.orderData.productName ?? '',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            '₹${widget.orderData.productPrice ?? ''}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColoring.successPopup,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.orderData.productShortDescription ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColoring.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        discriptionWiget()
                      ],
                    ),
                  ),
                  AppSpacing.ksizedBox10,
                  const Divider(),
                  // RowTwoItemWidget(
                  //   text1: 'Total Amount:',
                  //   text2: '₹${orderData.servicePrice}',
                  //   fontWeight1: FontWeight.bold,
                  //   fontWeight2: FontWeight.bold,
                  //   fontSize1: 16,
                  //   fontSize2: 18,
                  //   color2: AppColoring.successPopup,
                  // ),
                  AppSpacing.ksizedBox80,
                ],
              ),
            );
          },
        ),
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
              widget.orderData.productDescription ?? '',
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

class _StepChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _StepChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: FittedBox(
          child: Text(
            label,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10),
          ),
        ),
        leading: isActive
            ? const CircleAvatar(
                backgroundColor: AppColoring.successPopup,
                radius: 12,
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: AppColoring.kAppWhiteColor,
                    size: 20,
                  ),
                ),
              )
            : const CircleAvatar(
                backgroundColor: AppColoring.errorPopUp,
                radius: 12,
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: AppColoring.kAppWhiteColor,
                    size: 20,
                  ),
                ),
              ),
      ),
    );
  }
}
