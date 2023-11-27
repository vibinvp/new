import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/category/category_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/model/Category/get_category_model.dart';
import 'package:paystome/utility/custom_paiting.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/VideoList/video_list_screeen.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryController categoryController;
  final ScrollController _scrollController = ScrollController();
  int countval = 0;

  @override
  void initState() {
    categoryController =
        Provider.of<CategoryController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (countval == 0) {
        categoryController.getcategoryList(context);
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        countval = countval + int.parse(AppConstant.perPage);
        categoryController.getcategoryList(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // controller: _scrollController,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Consumer(
        builder: (context, CategoryController category, child) {
          return category.categoryModel == null
              ? const ShimmerEffect()
              : category.categoryList.isEmpty
                  ? const SizedBox(
                      height: 800,
                      child: Center(
                        child: Text('No Category Found'),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: category.categoryList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        List<Offset> circleOffsets;
                        const yOffset = 90.0; // Adjust this value as needed
                        if (index <= category.categoryList.length - 2) {
                          circleOffsets = List.generate(
                              category.categoryList.length - 1, (i) {
                            log(i.toString());
                            return Offset(20.0, i * 50.0 + 40.0 + yOffset);
                          });
                        } else {
                          circleOffsets = [];
                        }

                        return CustomPaint(
                          foregroundPainter:
                              ConnectingLinesPainter(circleOffsets),
                          child: gridViewItem(
                            category.categoryList[index],
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }

  Widget gridViewItem(
    CategoryData value,
  ) {
    return InkWell(
      onTap: () {
        RouteConstat.nextNamed(
            context,
            VideoListScreen(
              catName: value.name ?? '',
              catId: value.id ?? '',
            ));
        // RouteConstat.nextNamed(
        //     context,
        //     YoutubeVideoScreen(
        //       videoUrl: 'https://www.youtube.com/watch?v=L9cP9OTUstA',
        //     ));
      },
      child: SizedBox(
        height: 170,
        child: Stack(
          children: [
            Positioned(
              top: 75,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColoring.textDim),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Card(
              elevation: 0,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColoring.textDim),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                AppSpacing.ksizedBox30,
                                Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColoring.successPopup
                                            .withOpacity(.6)),
                                    color: AppColoring.successPopup
                                        .withOpacity(.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Videos ${value.prodCount ?? '0'}/${categoryController.categoryModel!.totalProduct ?? '0'}',
                                          style: TextStyle(
                                            color: AppColoring.successPopup
                                                .withOpacity(1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSpacing.ksizedBox10,
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
                                  child: value.image == null
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
                                              value.image.toString()),
                                ),
                              ),
                            ),
                            AppSpacing.ksizedBox10,
                          ],
                        ),
                        AppSpacing.ksizedBoxW20,
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 0,
                            backgroundColor: AppColoring.textLight,
                          ),
                          CircleAvatar(
                            radius: 0,
                            backgroundColor: AppColoring.textLight,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose(); // Don't forget to call super.dispose()
  }
}
