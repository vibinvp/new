import 'package:flutter/material.dart';

class RouteConstat {
  static void nextNamed(BuildContext context, Widget pageName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => pageName,
      ),
    );
  }

  static void nextReplaceNamed(BuildContext context, Widget pageName) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => pageName,
      ),
    );
  }

  static void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void nextRemoveUntileNamed(BuildContext context, Widget pageName) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => pageName,
        ),
        (route) => false);
  }
}
