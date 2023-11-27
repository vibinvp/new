import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/model/Authentication/message_response_model.dart';
import 'package:paystome/utility/dio_exception.dart';
import 'package:paystome/utility/enum_address.dart';
import 'package:paystome/view/Authentication/screen_otp.dart';

class SendOTPController with ChangeNotifier {
  OtpFieldController otpController = OtpFieldController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController enteirdOTPController = TextEditingController();
  int timeRemaining = 59;
  bool isShowPIN = true;
  bool enableResend = false;
  late Timer timer;
  bool checkedValue = true;
  MessageModel? model;
  void onRememberMeChecked(bool newValue) {
    checkedValue = newValue;
    notifyListeners();
  }

  setPinFromPayment(String pin) {
    enteirdOTPController.text = pin;
    log('PIN ---------${enteirdOTPController.text}');
    notifyListeners();
  }

  showPin() {
    isShowPIN = !isShowPIN;
    notifyListeners();
  }

  void setTimer() {
    timeRemaining = 59;
    notifyListeners();
  }

  void changeTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (timeRemaining != 0) {
          timeRemaining--;
          notifyListeners();
        } else {
          enableResend = true;
          notifyListeners();
        }
      },
    );
  }

  void setResendVisibility(bool newValue) {
    // enableResend = newValue;
    timeRemaining = 59;
    notifyListeners();
  }

  bool isLoadSndOtp = false;
  Future<bool> sndotp(BuildContext context, {required String value,required String refId}) async {
    bool check = false;
    notifyListeners();
    try {
      isLoadSndOtp = true;
      notifyListeners();

      var paremeters = {
        MOBILE: value,
        REFFERALID: refId,
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.usersndOtp, paremeters)
          .then((value) {
        model = MessageModel.fromJson(value);
        if (model != null) {
          if (model!.status == true) {
            showToast(msg: model!.message ?? '', clr: AppColoring.successPopup);

            // RouteConstat.nextNamed(
            //     context,
            //     ScreenOtp(
            //       type: ActionTypeOTP.registerOTP,
            //       mobile: value,
            //     ));
            check = true;
            notifyListeners();
            isLoadSndOtp = false;
            notifyListeners();
          } else {
            showToast(msg: model!.message ?? '', clr: AppColoring.errorPopUp);
            isLoadSndOtp = false;
            notifyListeners();
          }
        } else {
          isLoadSndOtp = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadSndOtp = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
    return check;
  }

  Future<bool> sndotpForget(
    BuildContext context, {
    required String value,
  }) async {
    bool check = false;
    notifyListeners();
    try {
      isLoadSndOtp = true;
      notifyListeners();

      var paremeters = {
        USERNAME: value,
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.usersndOtp, paremeters)
          .then((value) {
        model = MessageModel.fromJson(value);
        if (model != null) {
          if (model!.status == true) {
            log(ActionTypeOTP.forgotOTP.toString());
            showToast(msg: model!.message ?? '', clr: AppColoring.successPopup);
            check = true;
            notifyListeners();
            isLoadSndOtp = false;
            notifyListeners();
          } else {
            showToast(msg: model!.message ?? '', clr: AppColoring.errorPopUp);
            isLoadSndOtp = false;
            notifyListeners();
          }
        } else {
          isLoadSndOtp = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadSndOtp = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
    return check;
  }
}
