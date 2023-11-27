import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paystome/controller/profile/profile_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/enum_address.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Authentication/screen_otp.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/pop_up_widget.dart';
import 'package:paystome/widget/textfeild_widget.dart';
import 'package:provider/provider.dart';

class BankDetilasScreen extends StatefulWidget {
  const BankDetilasScreen({super.key});

  @override
  State<BankDetilasScreen> createState() => _BankDetilasScreenState();
}

class _BankDetilasScreenState extends State<BankDetilasScreen> {
  late ProfileController profileController;
  @override
  void initState() {
    profileController = Provider.of<ProfileController>(context, listen: false);
    profileController.accountNumber = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getUserDetails(context);
      profileController.getBankDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          "Bank Details",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColoring.kAppBlueColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: form(),
            ),
            const SizedBox(height: 10),
            button(),
            AppSpacing.ksizedBox40,
          ],
        ),
      ),
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          AppSpacing.ksizedBox15,
          textFormFieldWidget('Bank Name', profileController.bankNameController,
              TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('Holder Name',
              profileController.holderNameController, TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldAccountNumberdWidget('Account Number',
              profileController.accountNumberController, TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldUpperCaseWidget('IFSC Code',
              profileController.ifscCodeController, TextInputType.text),
          AppSpacing.ksizedBox15,
        ],
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer(
        builder: (context, ProfileController value, child) {
          return value.isLoadSndOtp
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
                    if (value.bankNameController.text == '' ||
                        value.bankNameController.text.isEmpty ||
                        value.holderNameController.text == '' ||
                        value.holderNameController.text.isEmpty ||
                        value.accountNumberController.text == '' ||
                        value.accountNumberController.text.isEmpty ||
                        value.ifscCodeController.text == '' ||
                        value.ifscCodeController.text.isEmpty) {
                      showToast(
                          msg: 'Enter the all fields correctly',
                          clr: AppColoring.errorPopUp);
                    } else {
                      confirmEditBankDetails(context, onYesPressed: () {
                        RouteConstat.back(context);
                        value.sndotpUpdateBankDetails(context).then((value) {
                          if (value == true) {
                            RouteConstat.nextNamed(
                                context,
                                const ScreenOtp(
                                  type: ActionTypeOTP.bankDetailsOTP,
                                  mobile: '',
                                ));
                          }
                        });
                      });
                      // value.submitBankDetails(context: context);
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

  confirmEditBankDetails(BuildContext context,
      {required final Function onYesPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationDialog(
          icon: Utils.setPngPath('warning').toString(),
          title: 'Are you sure to confirm?',
          description: 'Do you want to update ?',
          onYesPressed: onYesPressed),
    );
  }

  Widget textFormFieldUpperCaseWidget(String text,
      TextEditingController? controller, TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: TextfeildWidget(
        label: text,
        text: '',
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: [
          UpperCaseTextFormatter(),
        ],
        textCapitalization: TextCapitalization.characters,
        onChanged: (p0) {
          p0.toUpperCase();
        },
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
        label: text,
        text: '',
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget textFormFieldAccountNumberdWidget(String text,
      TextEditingController? controller, TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Consumer(
        builder: (context, ProfileController value, child) {
          return TextfeildWidget(
            obscureText: value.accountNumber,
            label: text,
            text: '',
            controller: controller,
            keyboardType: keyboardType,
            suffixIcon: InkWell(
              onTap: () {
                value.changepasswodVisibility();
              },
              child: Icon(
                value.accountNumber ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          );
        },
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
