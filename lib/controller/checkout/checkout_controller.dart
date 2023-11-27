import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Authentication/message_response_model.dart';
import 'package:paystome/utility/dio_exception.dart';
import 'package:paystome/view/Checkout/order_success.dart';
import 'package:paystome/view/Checkout/upi_app.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class CheckoutController with ChangeNotifier {
  MessageModel? messageModel;
  bool isLoadPlaceOrder = false;

  Future<void> placeOrder({
    required BuildContext context,
    required String payType,
  }) async {
    try {
      isLoadPlaceOrder = true;
      notifyListeners();

      final userId = await LocalStorage.getUserUserIdSF();

      var paremeters = {
        USERID: userId,
        PAYMENTMODE: payType,
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.placeOrder, paremeters)
          .then((value) {
        if (value != null) {
          messageModel = MessageModel.fromJson(value);
          if (messageModel!.status == true) {
            showToast(
                msg: messageModel!.message ?? '',
                clr: AppColoring.successPopup);
            RouteConstat.nextRemoveUntileNamed(
                context, const OrderSuccessScreen());
            isLoadPlaceOrder = false;
            notifyListeners();
          } else {
            showToast(
                msg: messageModel!.message ?? '', clr: AppColoring.errorPopUp);
            RouteConstat.back(context);
            isLoadPlaceOrder = false;
            notifyListeners();
          }
        } else {
          isLoadPlaceOrder = false;
          notifyListeners();
        }
      });
    } catch (e) {
      log(e.toString());
      isLoadPlaceOrder = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  //----------------Paynment Helper ---------------------?/

  initPhonepe() async {
    PhonePePaymentSdk.init(AppConstant.phonePayenvironment,
            AppConstant.phonePayAppId, AppConstant.phonePayMerchentId, true)
        .then((val) => {print('PhonePe SDK Initialized -->>  $val')})
        .catchError((error) {
      return {};
    });
  }

  Object? result;

  Future<Map<dynamic, dynamic>?> startPGTransaction(
      String body,
      String callback,
      String checksum,
      Map<String, String> headers,
      BuildContext context,
      amount,
      String merchantTransactionId) async {
    PhonePePaymentSdk.startPGTransaction(body, callback, checksum, headers,
            AppConstant.phonePayapiEndpoint, AppConstant.phonePayPackgeName)
        .then((response) {
      if (kDebugMode) {
        print(
            'Phonepe responseee --------------------->>>  response $response ');
      }
      if (response != null) {
        String status = response['status'].toString();
        String error = response['error'].toString();
        if (status == 'SUCCESS') {
          if (kDebugMode) {
            print('Phonepe responseee --------------------->>>  $status ');
          }
          handlePaymentSuccess(amount, merchantTransactionId, context);
        } else {
          //  Get.to(() => const PaymentFailure());
          result = "Flow Completed - Status: $status and Error: $error";
        }
      } else {
        result = "Flow Incomplete";
      }

      print('result ---->>  $result');
    }).catchError(
      (error) {
        handleError(error);
        //  Get.to(() => const PaymentFailure());
        return <dynamic>{};
      },
    );
    return null;
  }

  goToPayment(double price, BuildContext context) {
    String merchantTransactionId =
        'DMH${DateTime.now().millisecondsSinceEpoch}';

    final jsonData = {
      "merchantId": AppConstant.phonePayMerchentId,
      "merchantTransactionId": merchantTransactionId,
      "merchantUserId": "MUID123",
      "amount": price * 100,
      "redirectUrl": "",
      "redirectMode": "POST",
      "callbackUrl": "",
      "mobileNumber": "9999999998",
      "paymentInstrument": {"type": "PAY_PAGE"},
      "deviceContext": {
        "deviceOS": Platform.isIOS ? "IOS" : "ANDROID",
      }
    };

    String jsonString = jsonEncode(jsonData);
    String base64Data = jsonString.toBase64;
    String dataToHash = base64Data +
        AppConstant.phonePayapiEndpoint +
        AppConstant.phonePaySaltKey;
    String sHA256 = generateSha256Hash(dataToHash);

    String checksum = '$sHA256###${AppConstant.phonePaySaltIndex}';

    startPGTransaction(
        base64Data,
        'https://webhook.site/callback-url',
        checksum,
        {"Content-Type": "application/json"},
        context,
        price,
        merchantTransactionId);
  }

  void handleError(error) {}

  void handlePaymentSuccess(amount, merchantTransactionId, context) async {
    //  placeOrder(context: context, payType: 'phonepe');
  }

  String generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  List<UPIApp> upiApps = [];
  void getInstalledUpiAppsForAndroid() {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getInstalledUpiAppsForAndroid().then((apps) {
        if (apps != null) {
          print('apps bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  __>>.>>  $apps');
          Iterable l = json.decode(apps);

          upiApps = List<UPIApp>.from(l.map((model) => UPIApp.fromJson(model)));
          String appString = '';
          for (var element in upiApps) {
            appString +=
                "${element.applicationName} ${element.version} ${element.packageName}";
          }
          print("1234567789991991919$upiApps");
          result = 'Installed Upi Apps - $appString';
        } else {
          result = 'Installed Upi Apps - 0';
        }
      }).catchError((error) {
        handleError("$error");
        return <dynamic>{};
      });
    }
  }
}

extension EncodingExtensions on String {
  /// To Base64
  /// This is used to convert the string to base64
  String get toBase64 {
    return base64.encode(toUtf8);
  }

  /// To Utf8
  /// This is used to convert the string to utf8
  List<int> get toUtf8 {
    return utf8.encode(this);
  }

  /// To Sha256
  /// This is used to convert the string to sha256
  String get toSha256 {
    return sha256.convert(toUtf8).toString();
  }
}
