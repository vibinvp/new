import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:paystome/controller/Dasboard/dashboard_controller.dart';
import 'package:paystome/controller/home/home_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/model/Category/get_category_model.dart';
import 'package:paystome/view/VideoList/video_list_screeen.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StickyCategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  StickyCategoryHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Calculate the actual height based on the available space
    final actualHeight = math.max(minHeight, maxHeight - shrinkOffset);

    return Container(
      color: Colors.white,
      height: actualHeight, // Customize the background color
      child: categoryWidget(context),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Widget categoryWidget(BuildContext context) {
    List<Color> darkColors = [
      Color.fromARGB(255, 12, 80, 144), // Darker Blue
      Color.fromARGB(255, 41, 83, 40), // Darker Green
      Color.fromARGB(255, 90, 39, 112), // Darker Purple
      const Color(0xFFD9BE3B), // Darker Yellow
      const Color(0xFFE88F7F), // Darker Coral
      const Color(0xFF6FC6B8), // Darker Teal
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Consumer2(
        builder:
            (context, HomeController service, DashboardController dash, child) {
          return service.isLoadCategory || service.categoryModel == null
              ? const ShimmerEffectGridview()
              : ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Courses',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () async {
                            //launchUPI();
                            dash.bottomShift(1);
                          },
                          child: const Text(
                            'Show All',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.ksizedBox10,
                    GridView.builder(
                      itemCount: service.categoryList.length >= 3
                          ? 3
                          : service.categoryList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 80,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return gridViewItem1(service.categoryList[index],
                            darkColors[index], context);
                      },
                    )
                  ],
                );
        },
      ),
    );
  }

  String upiUrl =
      "upi://pay?pa=is1.8130591543@finobank&pn=8130591543&mc=6012&tr=530033723094212608&tn=Shopping&am=1.0&mode=04&tid=530033723094212608";

  void launchUPI() async {
    if (!await launchUrl(Uri.parse(upiUrl))) {
      throw Exception('Could not launch $upiUrl');
    }
  }

  Widget gridViewItem1(CategoryData value, Color color, context) {
    return InkWell(
      onTap: () {
        RouteConstat.nextNamed(
            context,
            VideoListScreen(
              catName: value.name ?? '',
              catId: value.id ?? '',
            ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                // color: Color(colorData),
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Text(
                    // 'Category',
                    value.name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColoring.kAppWhiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
