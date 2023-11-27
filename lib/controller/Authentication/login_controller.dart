import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_headers.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Authentication/login_model.dart';
import 'package:paystome/utility/dio_exception.dart';
import 'package:paystome/view/Dashboard/screen_dashboard.dart';
import 'package:otp_text_field/otp_field.dart';

class LoginController with ChangeNotifier {
  OtpFieldController otpController = OtpFieldController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController enteirdOTPController = TextEditingController();
  int timeRemaining = 59;
  bool isShowPIN = true;
  bool enableResend = false;
  late Timer timer;
  LoginModel? loginModel;
  bool passwordShow = true;
  bool checkedValue = true;

  void changepasswodVisibility() {
    passwordShow = !passwordShow;
    notifyListeners();
  }

  void ontermsnadCondChecked(bool newValue) {
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

  bool isLoadLogin = false;
  void loginUser(BuildContext context) async {
    try {
      isLoadLogin = true;
      notifyListeners();

      var paremeters = {
        USERNAME: userNameController.text,
        PASSWORD: passwordController.text,
        DEVICETYPE: DeviceType.getPlatform(),
        DEVICETOKEN: '1',
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.userLogin, paremeters)
          .then((value) async {
        loginModel = LoginModel.fromJson(value);
        if (loginModel != null) {
          if (loginModel!.status == true) {
            RouteConstat.nextRemoveUntileNamed(context, const DashboardScreen());
            var getmodel = loginModel!.data!;
            await LocalStorage.saveUserLoggedInStatus('true');
            await LocalStorage.saveUserAuthenticationTokenSF(
                getmodel.token.toString());
            await LocalStorage.saveUserEmailSF(getmodel.email.toString());
            await LocalStorage.saveUserUserIdSF(getmodel.id.toString());
            await LocalStorage.saveNameSF(getmodel.firstname.toString());
            await LocalStorage.saveUserLastNameSF(getmodel.lastname.toString());
            await LocalStorage.saveUserPPSF(getmodel.profileAvatar.toString());
            await LocalStorage.saveUserMobileSF(getmodel.mobile.toString());
            await LocalStorage.saveUserPasswordSF(
                passwordController.text.toString());
            await LocalStorage.saveUserNameSF(
                userNameController.text.toString());

            showToast(
                msg: loginModel!.message ?? '', clr: AppColoring.successPopup);

            isLoadLogin = false;
            notifyListeners();
          } else {
            showToast(
                msg: loginModel!.message ?? '', clr: AppColoring.errorPopUp);
            isLoadLogin = false;
            notifyListeners();
          }
        } else {
          isLoadLogin = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadLogin = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
