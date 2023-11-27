import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Authentication/sign_up_controller.dart';
import 'package:paystome/controller/Authentication/snd_otp_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/enum_address.dart';
import 'package:paystome/view/Authentication/screen_otp.dart';
import 'package:paystome/view/Authentication/screen_signin.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/textfeild_widget.dart';
import 'package:provider/provider.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  late SignUpController signUpController;

  @override
  void initState() {
    signUpController = Provider.of<SignUpController>(context, listen: false);
    signUpController.mobileController.clear();
    signUpController.firstNameController.clear();
    signUpController.lastNameController.clear();
    signUpController.emailController.clear();
    signUpController.userNameController.clear();
    signUpController.passwordController.clear();
    signUpController.refferalCodeController.clear();
    signUpController.confirmPasswordController.clear();
    signUpController.isLoadRegister = false;
    signUpController.getCurrentLocation();
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
              height: 60,
            ),
            welcomeTextRow(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: form(),
            ),
            const SizedBox(height: 10),
            termsAndConditions(),
            const SizedBox(height: 20),
            button(),
            AppSpacing.ksizedBox40,
            signInButton(),
            AppSpacing.ksizedBox40,
          ],
        ),
      ),
    );
  }

  Widget buttonMap(String text, void Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 35,
              color: AppColoring.kAppColor,
            ),
            Text(text)
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
          "SIGN UP",
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
          numberTextFormField(),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('Username', signUpController.userNameController,
              TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('First Name',
              signUpController.firstNameController, TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('Last Name', signUpController.lastNameController,
              TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('E-mail', signUpController.emailController,
              TextInputType.emailAddress),
          AppSpacing.ksizedBox15,
          textFormFieldPasswordWidget(
            'Password',
            signUpController.passwordController,
            TextInputType.name,
          ),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('Confirm Password',
              signUpController.confirmPasswordController, TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('Refferal Code(Optional)',
              signUpController.refferalCodeController, TextInputType.name),
          AppSpacing.ksizedBox15,
        ],
      ),
    );
  }

  Widget textFormFieldWidget(String text, TextEditingController? controller,
      TextInputType? keyboardType) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: TextfeildWidget(
        label:text ,
        text: '',
        controller: controller,
        keyboardType: keyboardType,
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
        builder: (context, SignUpController value, child) {
          return TextfeildWidget(
            obscureText: value.passwordShow,
            label:text ,
        text: '',
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

  Widget textFormFieldAddressWidget(
      String text, TextEditingController? controller) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColoring.primeryBorder),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColoring.primeryBorder),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              maxLength: 1000,
              maxLines: 3,
              readOnly: false,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,

              controller: controller,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: text,
                hintStyle: const TextStyle(fontSize: 14),
                // suffixIcon: suffixIcon,
                // prefixIcon: prefixIcon,
                // border: border,
              ),
            ),
          ),
        ));
  }

  Widget numberTextFormField() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            debugPrint(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            debugPrint(value.toString());
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: AppColoring.textDark),
          textFieldController: signUpController.mobileController,
          formatInput: false,
          maxLength: 10,
          initialValue: PhoneNumber(isoCode: 'IN'),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          cursorColor: AppColoring.kAppColor,
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
            border: InputBorder.none,
            hintText: 'Phone Number',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
          ),
          onSaved: (PhoneNumber number) {
            debugPrint('On Saved: $number');
          },
        ),
      ),
    );
  }

  Widget forgetPassTextRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: const Text(
            "Forgot password?      ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColoring.kAppColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget termsAndConditions() {
    return SizedBox(
      height: 40,
      child: Consumer(
        builder: (context, SignUpController signup, child) {
          return CheckboxListTile(
            title: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'I agree with',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text: ' Terms & Condition',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            value: signup.checkedValue,
            onChanged: (newValue) {
              signup.onRememberMeChecked(newValue!);
            },
            controlAffinity: ListTileControlAffinity.leading,
          );
        },
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer2(
        builder:
            (context, SignUpController value, SendOTPController sndOTP, child) {
          return value.isLoadRegister || sndOTP.isLoadSndOtp
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
                    if (value.mobileController.text.length != 10) {
                      showToast(
                          msg: 'Enter 10 digit mobile number ',
                          clr: AppColoring.errorPopUp);
                    } else if (!isValidEmail(value.emailController.text)) {
                      showToast(
                        msg: 'Enter a valid email address',
                        clr: AppColoring.errorPopUp,
                      );
                    } else if (value.firstNameController.text == '' ||
                        value.firstNameController.text.isEmpty ||
                        value.emailController.text == '' ||
                        value.emailController.text.isEmpty ||
                        value.userNameController.text == '' ||
                        value.userNameController.text.isEmpty ||
                        value.passwordController.text == '' ||
                        value.passwordController.text.isEmpty ||
                        value.confirmPasswordController.text == '' ||
                        value.confirmPasswordController.text.isEmpty) {
                      showToast(
                          msg: 'Enter the all fields correctly',
                          clr: AppColoring.errorPopUp);
                    } else if (value.passwordController.text !=
                        value.confirmPasswordController.text) {
                      showToast(
                          msg:
                              'The Confirm Password field does not match the Password field.',
                          clr: AppColoring.errorPopUp);
                    } else if (value.checkedValue == false) {
                      showToast(
                          msg: 'Please accept terms & conditons ',
                          clr: AppColoring.errorPopUp);
                    } else {
                      sndOTP
                          .sndotp(context,
                              value: value.mobileController.text,
                              refId: value.refferalCodeController.text)
                          .then((value) {
                        if (value == true) {
                          RouteConstat.nextNamed(
                              context,
                              const ScreenOtp(
                                type: ActionTypeOTP.registerOTP,
                                mobile: '',
                              ));
                        }
                      });

                      // value.registerUser(context);
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

  bool isValidEmail(String email) {
    // Regular expression for basic email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  Widget signInButton() {
    return RichText(
      text: TextSpan(
        text: "Already have an account?  ",
        children: [
          TextSpan(
            text: "Sign In",
            style: const TextStyle(
                color: AppColoring.kAppColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                RouteConstat.nextRemoveUntileNamed(
                    context, const ScreenSignIn());
              },
          ),
        ],
        style: const TextStyle(color: AppColoring.textDim, fontSize: 18),
      ),
    );
  }
}
