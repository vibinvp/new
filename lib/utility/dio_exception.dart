import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paystome/helper/core/message.dart';

class DioExceptionhandler {
  static void errorHandler(Object e) async {
    if (e is DioException) {
      if (e.error is SocketException) {
        await showToast(msg: 'No Internet Connection', clr: Colors.red);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        await showToast(msg: 'Connection Timout', clr: Colors.red);
      } else if (e.type == DioExceptionType.receiveTimeout) {
        await showToast(msg: 'Reciever Timout', clr: Colors.red);
      } else if (e.type == DioExceptionType.cancel) {
        await showToast(msg: 'Request cancelled', clr: Colors.red);
      } else if (e.error == "Http status error [406]") {
        await showToast(msg: 'No Changes', clr: Colors.red);
      } else if (e.type == DioExceptionType.sendTimeout) {
        await showToast(msg: 'Request timeout', clr: Colors.red);
      } else if (e.type == DioExceptionType.badCertificate) {
        await showToast(msg: 'Something went Wrong', clr: Colors.red);
      } else if (e.type == DioExceptionType.badResponse) {
        await showToast(
            msg: 'Something went wrong server not responding ',
            clr: Colors.red);
      } else if (e.type == DioExceptionType.unknown) {
        await showToast(msg: 'Something went Wrong', clr: Colors.red);
      } else if (e.error ==
          "address return[Error]: (006) Request Throttled. Over Rate limit: up to 2 per sec. See geocode.xyz/pricing") {
        await showToast(msg: 'Something went Wrong', clr: Colors.red);
      } else {
        await showToast(msg: e.message.toString(), clr: Colors.red);
      }
    }
  }
}
