import 'package:flutter/material.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/widget/custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final String? adminText;
  final Function onYesPressed;
  final Function? onNoPressed;
  final bool isLogOut;
  const ConfirmationDialog({
    Key? key,
    required this.icon,
    this.title,
    required this.description,
    this.adminText,
    required this.onYesPressed,
    this.onNoPressed,
    this.isLogOut = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(icon, width: 50, height: 50),
              ),
              title != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, color: AppColoring.errorPopUp),
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(description,
                    style:
                        const TextStyle(fontSize: 16, color: AppColoring.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                    child: TextButton(
                  onPressed: () => isLogOut
                      ? onYesPressed()
                      : onNoPressed != null
                          ? onNoPressed!()
                          : RouteConstat.back(context),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).disabledColor.withOpacity(0.1),
                    minimumSize: const Size(1170, 40),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'CANCEL',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColoring.black),
                  ),
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: CustomButton(
                  radius: 5,
                  color: AppColoring.kAppColor,
                  buttonText: 'yes',
                  onPressed: () {
                   
                    onYesPressed();
                  },
                  height: 40,
                )),
              ])
            ]),
          )),
    );
  }
}
