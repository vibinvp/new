import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required String msg, required Color clr}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: clr,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
