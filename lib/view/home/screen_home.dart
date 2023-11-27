import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:paystome/controller/Dasboard/dashboard_controller.dart';
import 'package:paystome/controller/Services/services_controller.dart';
import 'package:paystome/controller/Settings/settind_controller.dart';
import 'package:paystome/controller/Wallet/wallet_controller.dart';
import 'package:paystome/controller/home/home_controller.dart';
import 'package:paystome/controller/profile/profile_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/clipper_class.dart';
import 'package:paystome/utility/responsive_units.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Profile/edit_profile.dart';
import 'package:paystome/view/cart/screen_cart.dart';
import 'package:paystome/view/home/widget/seccion_widget.dart';
import 'package:paystome/view/home/widget/sticking_category.dart';
import 'package:paystome/view/search/screen_search.dart';

import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late SettingController settingController;
  late HomeController homeController;
  late ServiceController serviceController;
  late ProfileController profileController;
  late WalletController walletController;

  @override
  void initState() {
    settingController = Provider.of<SettingController>(context, listen: false);
    profileController = Provider.of<ProfileController>(context, listen: false);
    homeController = Provider.of<HomeController>(context, listen: false);
    serviceController = Provider.of<ServiceController>(context, listen: false);
    walletController = Provider.of<WalletController>(context, listen: false);

    settingController.getCurrentLocation();
    homeController.getUserdata();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getUserDetails(context);
      walletController.getWallet();
    });

    super.initState();
  }

  Future<void> reffresh() async {
    homeController.getBanners(context);
    homeController.getUserdata();
    homeController.getcategoryList(context);
    profileController.getUserDetails(context);
    walletController.getWallet();
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
    return RefreshIndicator(
      onRefresh: () async {
        return reffresh();
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Consumer(
          builder: (context, ServiceController value, child) {
            return value.isLoadCheckPrchase
                ? showLoadingDialog(context)
                : const SizedBox();
          },
        ),
        backgroundColor: AppColoring.kAppWhiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              floating: false,
              snap: false,
              elevation: 0,
              expandedHeight: 280,
              actions: [
                InkWell(
                  onTap: () {
                    RouteConstat.nextNamed(context, const ScreenCart());
                  },
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    width: 40,
                    height: 40,
                    child: const CircleAvatar(
                        backgroundColor: AppColoring.kAppWhiteColor,
                        radius: 20,
                        child: Icon(IconlyBold.buy,
                            color: AppColoring.black, size: 28)),
                  ),
                ),
                AppSpacing.ksizedBoxW10,
                InkWell(
                  onTap: () {
                    RouteConstat.nextNamed(context, const ScreenSearch());
                  },
                  child: Hero(
                    tag: 'searchBar',
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      width: 40,
                      height: 40,
                      child: const CircleAvatar(
                          backgroundColor: AppColoring.kAppWhiteColor,
                          radius: 20,
                          child: Icon(Icons.search,
                              color: AppColoring.black, size: 28)),
                    ),
                  ),
                ),
                AppSpacing.ksizedBoxW5
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: clipShape(),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyCategoryHeaderDelegate(
                // Customize the minimum and maximum heights
                minHeight: 180,
                maxHeight: 180,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    categoryServices1(),
                    categoryServices2(),
                    categoryServices3(),
                  ],
                );
              }, childCount: 1),
            ),
          ],
        ),

        // SingleChildScrollView(
        //   physics: const BouncingScrollPhysics(),
        // child: Column(
        //   // physics: BouncingScrollPhysics(),
        //   children: [
        //     clipShape(),
        //     //  slider1Widget(),
        //     //  AppSpacing.ksizedBox15,
        //     categoryWidget(),
        //     AppSpacing.ksizedBox15,
        //     categoryServices1(),
        //     categoryServices2(),
        //     categoryServices3(),
        //   ],
        // ),
        // ),
      ),
    );
  }

  Widget sliderWidget() {
    return Consumer(
      builder: (context, HomeController value, child) {
        return value.isLoadBannner
            ? const SingleBallnerItemSimmer()
            : value.banner.isEmpty
                ? const Row()
                : Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: value.banner.length,
                        options: CarouselOptions(
                          height: 150,
                          viewportFraction: .8,
                          padEnds: false,
                          autoPlay: true,
                          initialPage: 0,
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (ctx, index, realIdx) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColoring.lightBg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: value.banner.isEmpty
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
                                              AppConstant.bannerImageUrl +
                                              value.banner[index]
                                                  .sliderBackgroundImage
                                                  .toString()),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
      },
    );
  }

  Widget categoryServicesHeading(String heading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Show All',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget categoryServices1() {
    return Consumer(
      builder: (context, HomeController category, child) {
        return category.isLoadCategory || category.categoryModel == null
            ? const ShimmerEffect()
            : category.categoryList.isEmpty
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('No Data Found'),
                    ),
                  )
                : SingleSection(
                    catId:
                        context.read<HomeController>().categoryList[0].id ?? '',
                    index: 0,
                    sectionTitle:
                        context.read<HomeController>().categoryList[0].name ??
                            '',
                    productList: category.categoryProducts1List,
                  );
      },
    );
  }

  Widget categoryServices2() {
    return Consumer(
      builder: (context, HomeController category, child) {
        return category.isLoadCategory || category.categoryModel == null
            ? const ShimmerEffect()
            : category.categoryList.isEmpty &&
                    category.categoryProducts2List.isNotEmpty
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('No Data Found'),
                    ),
                  )
                : SingleSection(
                    catId:
                        context.read<HomeController>().categoryList[1].id ?? '',
                    index: 0,
                    sectionTitle:
                        context.read<HomeController>().categoryList[1].name ??
                            '',
                    productList: category.categoryProducts2List,
                  );
      },
    );
  }

  Widget categoryServices3() {
    return Consumer(
      builder: (context, HomeController category, child) {
        return category.isLoadCategory || category.categoryModel == null
            ? const ShimmerEffect()
            : category.categoryList.isEmpty &&
                    category.categoryProducts3List.isNotEmpty
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('No Data Found'),
                    ),
                  )
                : SingleSection(
                    catId:
                        context.read<HomeController>().categoryList[2].id ?? '',
                    index: 0,
                    sectionTitle:
                        context.read<HomeController>().categoryList[2].name ??
                            '',
                    productList: category.categoryProducts3List,
                  );
      },
    );
  }

  Widget clipShape() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    var large = ResponsiveWidget.isScreenLarge(width, pixelRatio);
    var medium = ResponsiveWidget.isScreenMedium(width, pixelRatio);
    return Column(
      children: [
        Opacity(
          opacity: 0.88,
          child: Container(
            height: 40,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColoring.kAppColor, AppColoring.kAppColor],
              ),
            ),
          ),
        ),
        Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.75,
              child: ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: large
                      ? height / 3
                      : (medium ? height / 3.2 : height / 3.5),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColoring.kAppColor,
                        AppColoring.kAppColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height:
                      large ? height / 3 : (medium ? height / 3.2 : height / 4),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColoring.kAppColor, AppColoring.kAppColor],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // top: 40,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Consumer3(
                    builder: (context,
                        ProfileController value,
                        DashboardController dash,
                        WalletController wallet,
                        child) {
                      return value.userDetailsModel == null
                          ? const SingleItemSimmer()
                          : InkWell(
                              onTap: () {
                                RouteConstat.nextNamed(
                                    context, EditProfileScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  value.profilePic.isNotEmpty
                                      ? Material(
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          elevation: 8,
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              child: CachedNetworkImage(
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                          downloadProgress) {
                                                    return const SingleBallnerItemSimmer();
                                                  },
                                                  fit: BoxFit.fill,
                                                  imageUrl:
                                                      // ApiBaseConstant.baseMainUrl +
                                                      //     AppConstant.profileImageUrl +
                                                      value.profilePic),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 130,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    Utils.setPngPath('logo'))),
                                          ),
                                        ),
                                  AppSpacing.ksizedBoxW15,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${value.nameController.text} ${value.lastnameController.text}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColoring.kAppWhiteColor),
                                      ),
                                      Text(
                                        'Your earnings :  ₹${wallet.walletModel == null ? '00' : wallet.walletModel!.data == null ? '00' : wallet.walletModel!.data!.referTotal == null ? '00' : wallet.walletModel!.data!.referTotal!.totalProductSale!.unpaid == null ? '00' : wallet.walletModel!.data!.referTotal!.totalProductSale!.unpaid.toString().replaceAll('Rs', '')}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: AppColoring.kAppWhiteColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                  AppSpacing.ksizedBox20,
                  sliderWidget(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 100,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
