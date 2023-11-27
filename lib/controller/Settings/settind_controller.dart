// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/model/Settings/admin_details_model.dart';
import 'package:paystome/utility/dio_exception.dart';

class SettingController with ChangeNotifier {
  String currentAddresss = '';
  double currentLatitude = 0.0;
  double currentlongitude = 0.0;
  StroDetailsModel? stroDetailsModel;
  List<StoreData> storeDetailsList = [];

  Future getCurrentLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        await Geolocator.requestPermission();
      } else {
        Geolocator.getCurrentPosition().then((value) async {
          currentLatitude = value.latitude;
          currentlongitude = value.longitude;
          notifyListeners();
          List<Placemark> placemark =
              await placemarkFromCoordinates(value.latitude, value.longitude);

          var address;
          address = placemark[0].name;
          address = address + ',' + placemark[0].subLocality;
          address = address + ',' + placemark[0].locality;
          address = address + ',' + placemark[0].administrativeArea;
          address = address + ',' + placemark[0].country;
          address = address + ',' + placemark[0].postalCode;
          currentAddresss = address ?? '';

          notifyListeners();
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //  Future<void> updateFcmToken(String userId, context) async {
  //   try {
  //     final fcmToken = await LocalStorage.getUseFcmTokentSF();

  //     var paremeters = {
  //       USERID: userId,
  //       FCMKEY: fcmToken,
  //     };
  //     final response =
  //         await ApiBaseHelper.postAPICall(ApiEndPoint.updateFcm, paremeters);

  //     if (response != null) {
  //     } else {}
  //   } catch (e) {
  //     log("Error occurred: $e");
  //     notifyListeners();
  //     DioExceptionhandler.errorHandler(e);
  //   }
  // }

  ///--------------------------get Strore Details-------------------------------------///
  bool isLoadgetDetails = false;
  void getStoreDetails(
    BuildContext context,
  ) async {
    try {
      isLoadgetDetails = true;
      notifyListeners();

      final response =
          await ApiBaseHelper.getAPICall(ApiEndPoint.getSettings, {});

      if (response != null) {
        stroDetailsModel = StroDetailsModel.fromJson(response);

        if (stroDetailsModel != null) {
          if (stroDetailsModel!.status == true) {
            List<StoreData> data = ((response['data']) as List)
                .map((data) => StoreData.fromJson(data))
                .toList();

            storeDetailsList = data;

            isLoadgetDetails = false;
            notifyListeners();
          } else {
            storeDetailsList = [];
            showToast(
                msg: stroDetailsModel!.message ?? '',
                clr: AppColoring.errorPopUp);
            isLoadgetDetails = false;
            notifyListeners();
          }
        } else {
          isLoadgetDetails = false;

          notifyListeners();
        }
      } else {
        isLoadgetDetails = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadgetDetails = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

 
}
