import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Authentication/forgot_passweord_controler.dart';
import 'package:paystome/controller/Authentication/sign_up_controller.dart';
import 'package:paystome/controller/Authentication/snd_otp_controller.dart';
import 'package:paystome/controller/profile/profile_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/utility/enum_address.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_text_field.dart';

class ScreenOtp extends StatefulWidget {
  const ScreenOtp({
    super.key,
    required this.mobile,
    required this.type,
  });
  final String mobile;
  final ActionTypeOTP type;

  @override
  State<ScreenOtp> createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  late SendOTPController sendOTPController;

  @override
  void initState() {
    sendOTPController = Provider.of<SendOTPController>(context, listen: false);
    sendOTPController.changeTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sendOTPController.setTimer();
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
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: SizedBox(
                height: 160,
                child: Image.asset(Utils.setPngPath("logo")),
              ),
            ),
            AppSpacing.ksizedBox50,
            welcomeTextRow(),
            otpText(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: form(),
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 30),
            button(),
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
          "Verification",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AppColoring.textDark),
        ),
      ],
    );
  }

  otpText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Add verification code sent on your number',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColoring.textDark.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          otpTextFormField(),
        ],
      ),
    );
  }

  Widget otpTextFormField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 20),
      child: Consumer(
        builder: (context, SendOTPController otpContr, child) {
          return Column(
            children: [
              OTPTextField(
                  controller: otpContr.otpController,
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 60,
                  keyboardType: TextInputType.number,
                  obscureText: otpContr.isShowPIN,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 8,
                  style: const TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    log('PIN Changed: $pin');
                    otpContr.setPinFromPayment(pin);
                  },
                  onCompleted: (pin) {
                    if (kDebugMode) {
                      print('Completed: $pin');
                    }
                  }),
              AppSpacing.ksizedBox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  timeCountWidget(),
                  otpContr.isShowPIN
                      ? TextButton.icon(
                          onPressed: () {
                            otpContr.showPin();
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: AppColoring.kAppColor.withOpacity(.8),
                          ),
                          label: Text(
                            'Show',
                            style: TextStyle(
                              color: AppColoring.kAppColor.withOpacity(.8),
                            ),
                          ),
                        )
                      : TextButton.icon(
                          onPressed: () {
                            otpContr.showPin();
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: AppColoring.kAppColor.withOpacity(.8),
                          ),
                          label: Text(
                            'Less',
                            style: TextStyle(
                              color: AppColoring.kAppColor.withOpacity(.8),
                            ),
                          ),
                        ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget timeCountWidget() {
    return Consumer4(
      builder: (context, SignUpController value, SendOTPController otpContr,
          ProfileController profile, ForgotPasswordController forgot, child) {
        return Row(
          children: [
            AppSpacing.ksizedBoxW15,
            otpContr.timeRemaining != 0
                ? Text(
                    '00:${otpContr.timeRemaining}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  )
                : InkWell(
                    onTap: () async {
                      otpContr.setTimer();
                      if (widget.type == ActionTypeOTP.registerOTP) {
                        otpContr.sndotp(context,
                            refId: value.refferalCodeController.text,
                            value: value.mobileController.text);
                      } else if (widget.type == ActionTypeOTP.bankDetailsOTP) {
                        profile.sndotpUpdateBankDetails(context);
                      } else {
                        otpContr.sndotpForget(context,
                            value: forgot.userNameController.text);
                      }
                    },
                    child: Text(
                      'RESEND',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
          ],
        );
      },
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer4(
        builder: (context, SignUpController value, SendOTPController otpContr,
            ProfileController profile, ForgotPasswordController forgot, child) {
          return value.isLoadRegister ||
                  forgot.isLoadForgot ||
                  profile.isLoadSubmitDetails
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
                    if (otpContr.enteirdOTPController.text.length != 4) {
                      showToast(
                          msg: 'Enter valid OTP', clr: AppColoring.errorPopUp);
                    } else {
                      if (widget.type == ActionTypeOTP.registerOTP) {
                        value.registerUser(context,
                            otp: otpContr.enteirdOTPController.text);
                      } else if (widget.type == ActionTypeOTP.bankDetailsOTP) {
                        profile.submitBankDetails(
                            context: context,
                            otp: otpContr.enteirdOTPController.text);
                      } else {
                        forgot.forgotPassword(context,
                            otp: otpContr.enteirdOTPController.text);
                      }
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
                      'Submit',
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
