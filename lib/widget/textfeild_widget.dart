import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfeildWidget extends StatelessWidget {
  const TextfeildWidget({
    Key? key,
    this.validator,
    required this.text,
    this.icon,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.autovalidateMode,
    this.border,
    this.prefixIcon,
    this.readOnly,
    this.maxLength,
    this.obscureText,
    this.label, this.inputFormatters, this.textCapitalization, this.onChanged,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String text;
  final String? label;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final AutovalidateMode? autovalidateMode;
  final InputBorder? border;
  final bool? readOnly;
  final bool? obscureText;
  final int? maxLength;  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
         inputFormatters: inputFormatters,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
         onChanged: onChanged,
        maxLength: maxLength,
        readOnly: readOnly ?? false,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: text,
          labelText: label,
          hintStyle: const TextStyle(fontSize: 14),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          // border: border,
        ),
      ),
    );
  }
}
