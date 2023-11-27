import 'package:flutter/material.dart';
import 'package:paystome/helper/core/color_constant.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final IconData? icon;
  final double radius;
  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.color,
      this.icon,
      this.radius = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : color ?? Theme.of(context).primaryColor,
      minimumSize:
          Size(width != null ? width! : 1170, height != null ? height! : 45),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Padding(
      padding: margin == null ? const EdgeInsets.all(0) : margin!,
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null
              ? Icon(icon,
                  color: transparent
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor)
              : const SizedBox(),
          SizedBox(width: icon != null ? 10 : 0),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColoring.kAppWhiteColor,
            ),
          )
        ]),
      ),
    );
  }
}
