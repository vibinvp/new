import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:paystome/controller/Dasboard/dashboard_controller.dart';
import 'package:paystome/controller/Services/services_controller.dart';
import 'package:paystome/controller/Settings/settind_controller.dart';
import 'package:paystome/controller/Wallet/wallet_controller.dart';
import 'package:paystome/controller/home/home_controller.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<TabItem> items = [
    const TabItem(
      icon: IconlyBold.home,
      //title: 'Home',
      // title: ' ',
    ),
    const TabItem(
      icon: IconlyBold.category,
      // title: 'Course category',
      // title: ' ',
    ),
    const TabItem(
      icon: IconlyBold.wallet,
      // title: ' ',
      // title: 'Earnings',
    ),
    const TabItem(
      icon: IconlyBold.profile,
      // title: ' ',
      // title: 'Profile',
    ),
  ];

  final iconList = <Widget>[
    const Icon(
      IconlyBold.home,
      size: 30,
      color: AppColoring.kAppWhiteColor,
    ),
    const Icon(
      IconlyBold.category,
      size: 30,
      color: AppColoring.kAppWhiteColor,
    ),
    const Icon(
      IconlyBold.wallet,
      size: 30,
      color: AppColoring.kAppWhiteColor,
    ),
    const Icon(
      IconlyBold.profile,
      size: 30,
      color: AppColoring.kAppWhiteColor,
    ),
  ];

  late DashboardController dashboardController;
  late SettingController settingController;
  late HomeController homeController;
  late ServiceController serviceController;
  late WalletController walletController;
  @override
  void initState() {
    dashboardController =
        Provider.of<DashboardController>(context, listen: false);
    dashboardController.currentPageIndex = 0;
    homeController = Provider.of<HomeController>(context, listen: false);
    walletController = Provider.of<WalletController>(context, listen: false);
    settingController = Provider.of<SettingController>(context, listen: false);
    serviceController = Provider.of<ServiceController>(context, listen: false);

    settingController.getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getUserdata();
      homeController.getBanners(context);
      homeController.getcategoryList(context);
      walletController.getWallet();
      // serviceController.getHomeServive(context, '0');
      // serviceController.getRoadSideServive(context, '0');
    });
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder:
          (BuildContext context, DashboardController value, Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            value.bottomNavbar();
            return false;
          },
          child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: value.bottomNavigationKey,
              index: 0,
              height: 60.0,
              items: iconList,
              color: AppColoring.kAppColor,
              buttonBackgroundColor: AppColoring.kAppColor,
              backgroundColor: AppColoring.kAppWhiteColor,
              animationCurve: Curves.linearToEaseOut,
              animationDuration: const Duration(milliseconds: 600),
              onTap: (newIndex) {
                value.bottomShift(newIndex);
              },
              letIndexChange: (index) => true,
            ),

            // bottomNavigationBar: AnimatedBottomNavigationBar(
            //     iconSize: 25,
            //     titleStyle: TextStyle(fontSize: 10),
            //     items: items,
            //     backgroundColor: AppColoring.kAppWhiteColor.withOpacity(.2),
            //     color: AppColoring.black,
            //     colorSelected: AppColoring.kAppColor,
            //     indexSelected: value.currentPageIndex,
            //     onTap: (int newIndex) {
            //       value.bottomShift(newIndex);
            //     }),

            // body: value.pages[value.currentPageIndex],
            // bottomNavigationBar:

            //  BottomNavigationBar(
            //   elevation: 0,
            //   showSelectedLabels: true,
            //   showUnselectedLabels: true,
            //   selectedItemColor: AppColoring.kAppColor,
            //   unselectedItemColor: const Color.fromARGB(255, 70, 69, 69),
            //   selectedLabelStyle: TextStyle(color: AppColoring.kAppColor),
            //   currentIndex: value.currentPageIndex,
            //   onTap: (newIndex) {
            //     value.bottomShift(newIndex);
            //   },
            //   type: BottomNavigationBarType.fixed,
            //   items: const [
            //     BottomNavigationBarItem(
            //       icon: Icon(
            //         Icons.home,
            //         size: 30,
            //       ),
            //       label: 'Home',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(
            //         Icons.category,
            //         size: 30,
            //       ),
            //       label: '',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(
            //         Icons.shopping_bag,
            //         size: 30,
            //       ),
            //       label: '',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(
            //         Icons.person,
            //         size: 32,
            //       ),
            //       label: 'Account',
            //     ),
            //   ],
            // ),
            body: value.pages[value.currentPageIndex],
          ),
        );
      },
    );
  }
}
