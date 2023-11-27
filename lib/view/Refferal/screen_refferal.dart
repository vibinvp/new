import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paystome/controller/Refferal/refferal_controller.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomAppBar(),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? refferalCode;
  @override
  void initState() {
    getRef();
    super.initState();
  }

  void getRef() async {
    var code = await LocalStorage.getUserNameFromSF();
    setState(() {
      refferalCode = code;
    });
    log('reffff   -------$refferalCode');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 0,
          backgroundColor: AppColoring.kAppColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            ),
          ),
          title: const Text(
            'Refer & Earn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        bannerWidget(context),
        AppSpacing.ksizedBox15,
        stepTexts(),
        AppSpacing.ksizedBox15,
        refferCode(),
        AppSpacing.ksizedBox80,
        inviteButtons(),
        AppSpacing.ksizedBox15,
      ],
    );
  }

  Widget bannerWidget(context) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/reffer.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                AppSpacing.ksizedBox50,
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/reffstep.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 160,
              left: 20,
              right: 20,
              child: headingText(
                  '3 Steps to Refer and Earn', Icons.signal_cellular_alt_sharp),
            ),
          ],
        ),
      ],
    );
  }

  Widget stepTexts() {
    return Column(
      children: [
        listtileWidget('Step 1 :',
            'Download the app and use my referral link to     sign up'),
        AppSpacing.ksizedBox10,
        listtileWidget('Step 2 :',
            'Explore the Paystome app for your regular transactions and needs, and earn cash back'),
        AppSpacing.ksizedBox10,
        listtileWidget('Step 3 :',
            'Refer your friends and get a cashback referral on Purchasing videos'),
      ],
    );
  }

  Widget submitButton(String text, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color: AppColoring.kAppColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget refferCode() {
    return Container(
      width: 280,
      //  / height: 40,
      decoration: BoxDecoration(
        border: Border.all(),
        // color: Color.fromARGB(255, 57, 46, 118),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'REFF.CODE :',
                style: TextStyle(
                  color: AppColoring.blackLight,
                  fontSize: 14,
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
              ),
              Expanded(
                child: SelectableText(
                  refferalCode ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
              ),
              InkWell(
                onTap: () async {
                  await Clipboard.setData(
                    const ClipboardData(
                      text: '',
                    ),
                  ).then((value) {
                    showToast(
                        msg: 'Code Copied $refferalCode',
                        clr: AppColoring.errorPopUp);
                  });
                },
                child: const Text(
                  'COPY',
                  style: TextStyle(color: AppColoring.blackLight, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listtileWidget(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(text1),
          AppSpacing.ksizedBoxW15,
          Expanded(
            child: Text(
              text2,
            ),
          ),
        ],
      ),
    );
  }

  Widget inviteButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Consumer(
        builder: (context, RefferalController value, child) {
          return Row(
            children: [
              Expanded(
                child: submitButton(
                  'Refer User',
                  () {
                    if (Platform.isAndroid) {
                      Share.share(
                          "Step 1 : Invite Friends to Paystome app\nStep 2 : Your Friend will get Refferal Cashback\nStep 3 : As a free user, you will receive cash back earned by your direct referral  from this link: https://play.google.com/store/apps/details?id=${AppConstant.packageName}.\n Don't forget to use my referral code: $refferalCode");
                      //value.shareAndroidApp();
                    } else {
                      // value.shareIosApp();
                    }
                  },
                ),
              ),
              AppSpacing.ksizedBoxW15,
            ],
          );
        },
      ),
    );
  }

  Widget headingText(String text, IconData? icon) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColoring.kAppColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppSpacing.ksizedBoxW30,
          Icon(
            icon,
            //Icons.signal_cellular_alt_sharp,
            color: const Color(0xffE1646F),
            size: 32,
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Icon(
            icon,
            //Icons.signal_cellular_alt_sharp,
            color: const Color(0xffE1646F),
            size: 32,
          ),
          AppSpacing.ksizedBoxW30,
        ],
      ),
    );
  }

  Widget smallheadingText(String text, IconData? icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppSpacing.ksizedBoxW40,
        Icon(
          icon,
          //Icons.signal_cellular_alt_sharp,
          color: const Color(0xffE1646F),
          size: 20,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Icon(
          icon,
          //Icons.signal_cellular_alt_sharp,
          color: const Color(0xffE1646F),
          size: 20,
        ),
        AppSpacing.ksizedBoxW40,
      ],
    );
  }
}
