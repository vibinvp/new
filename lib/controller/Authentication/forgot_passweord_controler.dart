import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/model/Authentication/register_model.dart';
import 'package:paystome/utility/dio_exception.dart';
import 'package:paystome/view/Authentication/screen_signin.dart';

class ForgotPasswordController with ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  RegisterModel? registerModel;

  bool isLoadForgot = false;
  void forgotPassword(BuildContext context, {required String otp}) async {
    try {
      isLoadForgot = true;
      notifyListeners();

      var paremeters = {
        USERNAME: userNameController.text,
        PASSWORD: passwordController.text,
        OTP: otp,
      };
      await ApiBaseHelper.postAPICall(ApiEndPoint.forgotPassword, paremeters)
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
          isLoadForgot = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadForgot = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
