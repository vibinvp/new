import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:paystome/controller/Cart/cart_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/model/Services/service_details.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:provider/provider.dart';

class VideoDetailScreen extends StatelessWidget {
  const VideoDetailScreen({super.key, required this.serviceModel});

  final ProductsData serviceModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addToCartOrBuyNowButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: AppColoring.kAppColor,
        leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          serviceModel.productName ?? 'Details',
          maxLines: 2,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      backgroundColor: AppColoring.kAppWhiteColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          videoWidget(context),
          headingWiget(),
          shortDiscriptionWiget(),
          priceWidget(),
          discriptionWiget(),
          AppSpacing.ksizedBox50,
          // playButton(context),
        ],
      ),
    );
  }

  Widget playButton(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColoring.kAppColor),
            onPressed: () {
              // RouteConstat.nextNamed(
              //     context,
              // const VideoPlayerScreen(
              //   // title: 'Video',
              //   // videoId: 1,
              //   videoUrl:
              //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
              // ));
            },
            child: const Text(
              'Watch Now',
              style: TextStyle(
                color: AppColoring.kAppWhiteColor,
              ),
            )),
      ),
    );
  }

  Widget priceWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Price : ',
            style: TextStyle(
                color: AppColoring.black,
                fontWeight: FontWeight.w600,
                fontSize: 17),
          ),
          Text(
            '₹${serviceModel.productPrice}',
            style: const TextStyle(
                color: AppColoring.successPopup,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          )
          // TextButton.icon(
          //     style: ButtonStyle(
          //       shape: MaterialStateProperty.all(
          //         RoundedRectangleBorder(
          //           side: const BorderSide(
          //               color: AppColoring.black,
          //               width: 1,
          //               style: BorderStyle.solid),
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //       ),
          //     ),
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.thumb_up,
          //       color: AppColoring.black,
          //       size: 20,
          //     ),
          //     label: const Text(
          //       'Like',
          //       style: TextStyle(
          //         color: AppColoring.black,
          //       ),
          //     )),
          // TextButton.icon(
          //     style: ButtonStyle(
          //       shape: MaterialStateProperty.all(
          //         RoundedRectangleBorder(
          //           side: const BorderSide(
          //               color: AppColoring.black,
          //               width: 1,
          //               style: BorderStyle.solid),
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //       ),
          //     ),
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.share_outlined,
          //       color: AppColoring.black,
          //       size: 20,
          //     ),
          //     label: const Text(
          //       'Share',
          //       style: TextStyle(
          //         color: AppColoring.black,
          //       ),
          //     )),
          // TextButton.icon(
          //     style: ButtonStyle(
          //       shape: MaterialStateProperty.all(
          //         RoundedRectangleBorder(
          //           side: const BorderSide(
          //               color: AppColoring.black,
          //               width: 1,
          //               style: BorderStyle.solid),
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //       ),
          //     ),
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.download_for_offline_outlined,
          //       color: AppColoring.black,
          //       size: 23,
          //     ),
          //     label: const Text(
          //       'Download',
          //       style: TextStyle(
          //         color: AppColoring.black,
          //       ),
          //     ))
        ],
      ),
    );
  }

  Widget headingWiget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10),
      child: Text(
        serviceModel.productName ?? '',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget shortDiscriptionWiget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Text(
        serviceModel.productShortDescription ?? '',
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
              serviceModel.productDescription ?? '',
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

  Widget videoWidget(context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: AppColoring.lightBg,
            blurRadius: 15.0,
          ),
        ],
        borderRadius: BorderRadius.circular(0),
      ),
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: serviceModel.productFeaturedImage == null
              ? Opacity(
                  opacity: 1,
                  child: Image.asset(
                    Utils.setPngPath('banner2'),
                    fit: BoxFit.fill,
                  ))
              : CachedNetworkImage(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  imageUrl: ApiBaseConstant.baseUrl +
                      AppConstant.categoryImageUrl +
                      serviceModel.productFeaturedImage.toString(),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
        ),
      ),
    );
  }

  Widget addToCartOrBuyNowButton(BuildContext context) {
    return Consumer(builder: (context, CartController cartController, child) {
      return cartController.isLoadaddToCart
          ? const LoadreWidget()
          : Container(
            color: AppColoring.kAppWhiteColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 10,
                         
                        ),
                        onPressed: () {
                          cartController.addToCartProduct(context,
                              productId: serviceModel.productId.toString(),
                              type: 'add');
                        },
                        child: Center(
                          child: Text(
                            'ADDTO CART',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColoring.kAppColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: 'ubuntu',
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.ksizedBoxW15,
                  Expanded(
                    child: SizedBox(height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 10,
                          backgroundColor:     AppColoring.kAppColor,
                        ),
                        onPressed: () {
                          cartController.addToCartProduct(context,
                              productId: serviceModel.productId.toString(),
                              type: 'buy');
                        },
                        // height: 50,
                        // decoration: const BoxDecoration(
                        //   gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [
                        //         AppColoring.kAppColor,
                        //         AppColoring.kAppColor
                        //       ],
                        //       stops: [
                        //         0,
                        //         1
                        //       ]),
                        // ),
                        child: Center(
                          child: Text(
                            'BUY NOW',
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
            ),
          );
    });
    // return Container(
    //   height: 50,
    //   decoration: BoxDecoration(
    //     color: Colors.blue, // Container background color
    //     //   borderRadius: BorderRadius.circular(25), // Rounded corners
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       customButton(text: 'Add to Cart', color: AppColoring.textRed),
    //       // SizedBox(
    //       //   width: 20,
    //       //   height: double.infinity,
    //       //   child: CustomPaint(
    //       //     painter:
    //       //         DiagonalDivider(AppColoring.textRed, AppColoring.kAppColor),
    //       //   ),
    //       // ),
    //       customButton(text: 'Buy Now', color: AppColoring.kAppColor),
    //     ],
    //   ),
    // );
  }

  Widget customButton({required String text, Color? color}) {
    return Expanded(
        child: Container(
      width: 200,
      height: 200,
      color: Colors.blue, // Background color of the container
      child: CustomPaint(
        painter: CrossPainter(), // Custom painter to draw the cross
      ),
    ));
  }
}

class CrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Color of the lines
      ..strokeWidth = 2; // Line thickness

    // Draw the diagonal lines to form a cross
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
