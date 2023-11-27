import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Wallet/addmoney_controller.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/model/membership/plan_model.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class MembershipPlanScreen extends StatefulWidget {
  const MembershipPlanScreen({super.key});

  @override
  State<MembershipPlanScreen> createState() => _MembershipPlanScreenState();
}

class _MembershipPlanScreenState extends State<MembershipPlanScreen> {
  late PlanController planController;
  final ScrollController _scrollController = ScrollController();
  int countval = 0;

  @override
  void initState() {
    planController = Provider.of<PlanController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (countval == 0) {
        planController.getPlanDetails(context, '0');
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        countval = countval + int.parse(AppConstant.perPage);
        planController.getPlanDetails(context, countval.toString());
      }
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
          "Plans",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
      child: Consumer(builder: (context, PlanController value, child) {
        return value.isLoadFetchPlan
            ? const ShimmerEffect()
            : value.planList.isEmpty
                ? const SizedBox(
                    height: 800,
                    child: Center(
                      child: Text('No Servies Found'),
                    ),
                  )
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.planList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return gridViewIten(context, value.planList[index]);
                    },
                    separatorBuilder: (context, index) {
                      return AppSpacing.ksizedBox15;
                    },
                  );
      }),
    );
  }

  Widget gridViewIten(context, PlanData plan) {
    Color getRandomLightColor() {
      Random random = Random();
      return Color.fromARGB(
        200, // Alpha (opacity)
        200 + random.nextInt(56), // Lighter green (200-255)
        200 + random.nextInt(56), // Lighter green (200-255)
        200 + random.nextInt(56), // Lighter blue (200-255)
      );
    }

    Color randomColor = getRandomLightColor();
    return Card(
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
            color: randomColor, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(50),
                  //     child: plan. == null || plan.planImage == ''
                  //         ? Image.asset(
                  //             Utils.setPngPath("logo"),
                  //             fit: BoxFit.fill,
                  //           )
                  //         : CachedNetworkImage(
                  //             errorWidget: (context, url, error) {
                  //               return const Icon(Icons.error);
                  //             },
                  //             progressIndicatorBuilder:
                  //                 (context, url, downloadProgress) {
                  //               return const SingleBallnerItemSimmer();
                  //             },
                  //             fit: BoxFit.fill,
                  //             imageUrl: ApiBaseConstant.baseMainUrl +
                  //                 AppConstant.planImageUrl +
                  //                 plan.planImage.toString(),
                  //           ),
                  //   ),
                  // ),
                  AppSpacing.ksizedBoxW15,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name ?? '',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColoring.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.ksizedBox15,
              Text(
                plan.description ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColoring.black),
              ),
              AppSpacing.ksizedBox15,
              const Divider(),
              AppSpacing.ksizedBox15,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${plan.price}',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColoring.black),
                        ),
                        Text(
                          '(You will get ${plan.price} points in your wallet)',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColoring.black),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.ksizedBoxW5,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColoring.successPopup,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      showDilogueConfirm(context, planId: plan.id.toString());
                    },
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColoring.kAppWhiteColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showDilogueConfirm(BuildContext context, {required String planId}) {
    Dialog details = Dialog(
      elevation: 4,
      backgroundColor: AppColoring.kAppWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 180.0,
        width: 200.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppSpacing.ksizedBox5,
              const Text(
                'Are you sure',
                style: TextStyle(color: AppColoring.black, fontSize: 22.0),
              ),
              AppSpacing.ksizedBox10,
              const Text(
                'Do you want to buy new plan ?',
                style: TextStyle(color: AppColoring.black, fontSize: 16.0),
              ),
              AppSpacing.ksizedBox30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColoring.errorPopUp),
                      onPressed: () {
                        RouteConstat.back(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                            color: AppColoring.kAppWhiteColor, fontSize: 15.0),
                      ),
                    ),
                  ),
                  AppSpacing.ksizedBoxW25,
                  Expanded(
                    child: Consumer(
                      builder: (context, PlanController value, child) {
                        return
                            //  value.isLoadgetByPlan
                            //     ? const LoadreWidget()
                            //     :
                            ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColoring.successPopup),
                          onPressed: () {
                            // value.puchasePlan(context, planId);
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                                color: AppColoring.kAppWhiteColor,
                                fontSize: 15.0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => details,
    );
  }
}
