// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paystome/helper/api/api_headers.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/model/Authentication/register_model.dart';
import 'package:paystome/utility/dio_exception.dart';
import 'package:paystome/view/Authentication/screen_signin.dart';

class SignUpController with ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController refferalCodeController = TextEditingController();
  // TextEditingController pincodeController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController latitudeController = TextEditingController();
  // TextEditingController longitudeController = TextEditingController();
  RegisterModel? registerModel;
  bool checkedValue = true;
  bool passwordShow = false;
  void onRememberMeChecked(bool newValue) {
    checkedValue = newValue;
    notifyListeners();
  }

  void changepasswodVisibility() {
    passwordShow = !passwordShow;
    notifyListeners();
  }

  Future getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      await Geolocator.requestPermission();
    } else {
      Geolocator.getCurrentPosition().then((value) async {
        //  latitudeController.text = value.latitude.toString();
        //  longitudeController.text = value.longitude.toString();

        //  log(latitudeController.text.toString());
        // log(longitudeController.text.toString());
        List<Placemark> placemark =
            await placemarkFromCoordinates(value.latitude, value.longitude);

        var address;
        address = placemark[0].name;
        address = address + ',' + placemark[0].subLocality;
        address = address + ',' + placemark[0].locality;
        address = address + ',' + placemark[0].administrativeArea;
        address = address + ',' + placemark[0].country;
        address = address + ',' + placemark[0].postalCode;
        // addressController.text = address ?? '';
        //  cityController.text = placemark[0].locality ?? '';
        //  pincodeController.text = placemark[0].postalCode ?? '';
        //  stateController.text = placemark[0].administrativeArea ?? '';
        notifyListeners();
      });
    }
  }

  bool isLoadRegister = false;
  void registerUser(BuildContext context, {required String otp}) async {
    try {
      isLoadRegister = true;
      notifyListeners();

      var paremeters = {
        USERNAME: userNameController.text,
        FIRSTNAME: firstNameController.text,
        LASTNAME: lastNameController.text,
        EMAIL: emailController.text,
        PASSWORD: passwordController.text,
        CONFPASSWORD: confirmPasswordController.text,
        MOBILE: mobileController.text,
        REFFERALID: refferalCodeController.text == '' ||
                refferalCodeController.text.isEmpty
            ? "0"
            : refferalCodeController.text,
        DEVICETYPE: DeviceType.getPlatform(),
        DEVICETOKEN: '1',
        TERMS: checkedValue,
        OTP: otp,
      };
      await ApiBaseHelper.postAPICall(ApiEndPoint.userRegister, paremeters)
          .then((value) {
        log(value.toString());
        registerModel = RegisterModel.fromJson(value);

        if (registerModel != null) {
          if (registerModel!.status == true) {
            showToast(
                msg: registerModel!.message, clr: AppColoring.successPopup);
            RouteConstat.nextRemoveUntileNamed(context, const ScreenSignIn());
          } else {
            if (registerModel!.errors.isNotEmpty) {
              String errorMessage = "";
              registerModel!.errors.forEach((key, value) {
                errorMessage += "$value\n";
              });
              showToast(msg: errorMessage, clr: AppColoring.errorPopUp);
            } else {
              showToast(
                  msg: registerModel!.message, clr: AppColoring.errorPopUp);
            }
          }
          isLoadRegister = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadRegister = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
