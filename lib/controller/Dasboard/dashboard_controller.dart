import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:paystome/view/Account/account_screen.dart';
import 'package:paystome/view/Category/category_screen.dart';
import 'package:paystome/view/earnings/earning_screeen.dart';
import 'package:paystome/view/home/screen_home.dart';

class DashboardController with ChangeNotifier {
  int currentPageIndex = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  List pages = [
    const ScreenHome(),
    const CategoryScreen(),
    const MyEarningsScreen(),
    const AccountScreen(),
  ];

  Future<bool>? bottomNavbar() {
    if (currentPageIndex != 0) {
      final CurvedNavigationBarState? navBarState =
          bottomNavigationKey.currentState;
      navBarState?.setPage(0);
      currentPageIndex = 0;
      notifyListeners();
    } else {
      // exit(0);
    }
    return null;
  }

  void bottomShift(newIndex) {
    currentPageIndex = newIndex;

    notifyListeners();
  }

  void bottomShiftset3(newIndex) {
    final CurvedNavigationBarState? navBarState =
        bottomNavigationKey.currentState;
    navBarState?.setPage(3);
    currentPageIndex = 3;
    notifyListeners();
  }
}
