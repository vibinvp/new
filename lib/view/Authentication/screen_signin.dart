import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Authentication/login_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Authentication/forgot_password.dart';
import 'package:paystome/view/Authentication/screen_signup.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/textfeild_widget.dart';
import 'package:provider/provider.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({super.key});

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  late LoginController loginController;

  @override
  void initState() {
    loginController = Provider.of<LoginController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loginController.userNameController.clear();
      loginController.passwordController.clear();
      loginController.isLoadLogin = false;
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
            forgetPassTextRow(context),
            const SizedBox(height: 30),
            termsAndConditions(),
            const SizedBox(height: 30),
            button(),
            AppSpacing.ksizedBox40,
            signUpButton(),
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
          "SIGN IN",
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
          textFormFieldWidget('Username', loginController.userNameController,
              TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldPasswordWidget('Password',
              loginController.passwordController, TextInputType.text),
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

  Widget otpTextFormField() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: const TextfeildWidget(text: 'Enter OTP'),
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

  Widget usernameTextFormField() {
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
          textFieldController: loginController.userNameController,
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

  Widget forgetPassTextRow(BuildContext context) {
    return

        // TextButton(
        //   onPressed: () {},
        //   child: Text(
        //     "Forgot password?",
        //     style: TextStyle(
        //       fontWeight: FontWeight.w600,
        //       color: AppColoring.kAppColor,
        //       fontSize: 14,
        //     ),
        //   ),
        // );

        InkWell(
      onTap: () {
        RouteConstat.nextNamed(context, const ScreenForgotPass());
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Forgot password?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColoring.kAppColor,
              fontSize: 14,
            ),
          ),
          AppSpacing.ksizedBoxW25
        ],
      ),
    );
  }

  Widget termsAndConditions() {
    return SizedBox(
      height: 40,
      child: Consumer(
        builder: (context, LoginController login, child) {
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
            value: login.checkedValue,
            onChanged: (newValue) {
              login.ontermsnadCondChecked(newValue!);
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
      child: Consumer(
        builder: (context, LoginController value, child) {
          return value.isLoadLogin
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
                    } else if (value.checkedValue == false) {
                      showToast(
                          msg: 'Please accept terms & conditons ',
                          clr: AppColoring.errorPopUp);
                    } else {
                      value.loginUser(context);
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
                      'LOGIN',
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

  Widget signUpButton() {
    return RichText(
      text: TextSpan(
        text: "Don't have an account?  ",
        children: [
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
                color: AppColoring.kAppColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                  RouteConstat.nextNamed(context, const ScreenSignUp());
              },
          ),
        ],
        style: const TextStyle(color: AppColoring.textDim, fontSize: 18),
      ),
    );
  }
}
