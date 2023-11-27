

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/model/Refferal/network_model.dart';
import 'package:paystome/utility/dio_exception.dart';

class RefferalController with ChangeNotifier {
  // List<CategoryData> categoryList = [];
  MyNetWorkModel? myNetWorkModel;
  bool isLoadmyNetwork = false;
  List<ReferredUsersTree> referredUsersTree = [];

  void getReferalList(BuildContext context) async {
    try {
      isLoadmyNetwork = true;
      notifyListeners();

      final response =
          await ApiBaseHelper.getAPICall(ApiEndPoint.myNetwork, {});

      if (response != null) {
        if (kDebugMode) {
          print(
              'refferal----------->> ${response['data']['referred_users_tree']}');
        }
        myNetWorkModel = MyNetWorkModel.fromJson(response);
        if (myNetWorkModel != null && myNetWorkModel!.data != null) {
          final Map<String, dynamic> data = response;
          List<dynamic> usersList = data['data']['referred_users_tree'];

          if (kDebugMode) {
            print(
                'refferal----------->> ${data['data']['referred_users_tree']}');
          }

          referredUsersTree = usersList
              .map((json) => ReferredUsersTree.fromJson(json))
              .toList();

          notifyListeners();

          isLoadmyNetwork = false;
          notifyListeners();
        } else {
          isLoadmyNetwork = false;

          notifyListeners();
        }
      } else {
        isLoadmyNetwork = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadmyNetwork = false;
      if (kDebugMode) {
        print("refferal----------->> Error occurred category: $e");
      }
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  // shareAndroidApp() async {
  //   SharedPreferences pre = await SharedPreferences.getInstance();
  //   final refferalCode = pre.getString(REFERCODE);
  //   XFile image =
  //       await getImageFileFromAssets('assets/staticimage/invitebanner.png');

  //   if (CUR_USERID != '' || CUR_USERID != null) {
  //     final bytes =
  //         await rootBundle.load('assets/staticimage/invitebanner.png');
  //     final list = bytes.buffer.asUint8List();

  //     final tempDir = await getTemporaryDirectory();
  //     final file = await File('${tempDir.path}/invitebanner.png').create();
  //     file.writeAsBytesSync(list);
  //     // ignore: deprecated_member_use
  //     Share.shareFiles([(file.path)], text: shareLink
  //         //   "Step 1 : Invite Friends to AGS Kart app\nStep 2 : Your Friend will get 100 Royalty Points\nStep 3 : As a free user, you will receive 10% of the cash back earned by your direct referral. As a premium user, you will receive 50% of the cash back earned by all users directly and indirectly referred under you  from this link: https://play.google.com/store/apps/details?id=$packageName.\n Don't forget to use my referral code: $refferalCode"
  //         );
  //   } else {
  //     final bytes =
  //         await rootBundle.load('assets/staticimage/invitebanner.png');
  //     final list = bytes.buffer.asUint8List();

  //     final tempDir = await getTemporaryDirectory();
  //     final file = await File('${tempDir.path}/invitebanner.png').create();
  //     file.writeAsBytesSync(list);
  //     // ignore: deprecated_member_use
  //     Share.shareFiles([(file.path)], text: shareLink
  //         //  "Step 1 : Invite Friends to AGS Kart app\nStep 2 : Your Friend will get 100 Royalty Points\nStep 3 : As a free user, you will receive 10% of the cash back earned by your direct referral. As a premium user, you will receive 50% of the cash back earned by all users directly and indirectly referred under you  from this link: https://play.google.com/store/apps/details?id=$packageName.\n Don't forget to use my referral code: $refferalCode"
  //         );
  //   }
  //   // ignore: prefer_interpolation_to_compose_strings
  // }
}
