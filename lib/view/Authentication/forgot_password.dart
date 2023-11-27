import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Authentication/forgot_passweord_controler.dart';
import 'package:paystome/controller/Authentication/login_controller.dart';
import 'package:paystome/controller/Authentication/snd_otp_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/enum_address.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Authentication/screen_otp.dart';
import 'package:paystome/view/Authentication/screen_signup.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/textfeild_widget.dart';
import 'package:provider/provider.dart';

class ScreenForgotPass extends StatefulWidget {
  const ScreenForgotPass({super.key});

  @override
  State<ScreenForgotPass> createState() => _ScreenForgotPassState();
}

class _ScreenForgotPassState extends State<ScreenForgotPass> {
  late ForgotPasswordController forgotPasswordController;

  @override
  void initState() {
    forgotPasswordController =
        Provider.of<ForgotPasswordController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      forgotPasswordController.userNameController.clear();
      forgotPasswordController.passwordController.clear();
      forgotPasswordController.confPasswordController.clear();
      context.read<SendOTPController>().isLoadSndOtp = false;
      // forgotPasswordController.isLoadLogin = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColoring.kAppBlueColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: SizedBox(
                height: 160,
                child: Image.asset(
                  Utils.setPngPath("logo"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            AppSpacing.ksizedBox10,
            welcomeTextRow(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: form(),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 30),
            button(),
            AppSpacing.ksizedBox40,
          ],
        ),
      ),
    );
  }

  Widget welcomeTextRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppSpacing.ksizedBoxW30,
        Text(
          "RESET YOUR PASSWORD",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColoring.textDark),
        ),
      ],
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          textFormFieldWidget('Username',
              forgotPasswordController.userNameController, TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldPasswordWidget('Password',
              forgotPasswordController.passwordController, TextInputType.text),
          AppSpacing.ksizedBox15,
          textFormFieldWidget(
              'Confirm Password',
              forgotPasswordController.confPasswordController,
              TextInputType.text),
        ],
      ),
    );
  }

  Widget textFormFieldPasswordWidget(String text,
      TextEditingController? controller, TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Consumer(
        builder: (context, LoginController value, child) {
          return TextfeildWidget(
            obscureText: value.passwordShow,
            text: text,
            controller: controller,
            keyboardType: keyboardType,
            suffixIcon: InkWell(
              onTap: () {
                value.changepasswodVisibility();
              },
              child: Icon(
                value.passwordShow ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textFormFieldWidget(String text, TextEditingController? controller,
      TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: TextfeildWidget(
        text: text,
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer2(
        builder: (context, ForgotPasswordController value,
            SendOTPController sndOTP, child) {
          return sndOTP.isLoadSndOtp
              ? const LoadreWidget()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.all(0.0),
                    textStyle: const TextStyle(color: AppColoring.kAppColor),
                  ),
                  onPressed: () {
                    if (value.userNameController.text.isEmpty ||
                        value.userNameController.text == '') {
                      showToast(
                          msg: 'Please enter username  ',
                          clr: AppColoring.errorPopUp);
                    } else if (value.passwordController.text.isEmpty ||
                        value.passwordController.text == '' ||
                        value.confPasswordController.text.isEmpty ||
                        value.confPasswordController.text == '') {
                      showToast(
                          msg:
                              'Please Enter The Password and Confirm Password ',
                          clr: AppColoring.errorPopUp);
                    } else if (value.passwordController.text !=
                        value.confPasswordController.text) {
                      showToast(
                          msg:
                              'The Confirm Password field does not match the Password field.',
                          clr: AppColoring.errorPopUp);
                    } else {
                      log(ActionTypeOTP.forgotOTP.toString());

                      sndOTP
                          .sndotpForget(
                        context,
                        value: value.userNameController.text,
                      )
                          .then((value) {
                        if (value == true) {
                          RouteConstat.nextNamed(
                              context,
                              const ScreenOtp(
                                type: ActionTypeOTP.forgotOTP,
                                mobile: '',
                              ));
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColoring.kAppColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColoring.kAppWhiteColor,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
