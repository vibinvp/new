import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Phonepe/verify_wallet_payment.dart';
import 'package:paystome/view/Webview/phonepe_webview_payment.dart';

class PhonepePaymentController with ChangeNotifier {
  List<VerifyModelAddWallet> verifyPamentResponseData = [];

  bool isPayLoading = false;
  Future<void> initiatePhonePeTransaction(BuildContext context,
      {required String amount}) async {
    isPayLoading = true;
    notifyListeners();
    try {
      final userId = await LocalStorage.getUserUserIdSF();

      var parameter = {
        USERID: userId == null || userId == '' || userId.isEmpty ? '' : userId,
        AMOUNT: amount
      };

      // await PhonePeRepo.walletAddPhoneperepo(parameter).then((value) {
      //   bool error = value['error'];
      //   String msg = value['message'];
      //   dynamic data = value['data'];

      //   if (!error) {
      //     String payUrl = data['url'];
      //     String merchantTransactionId = data['txid'];
      //     payUrl = payUrl.replaceAll('\\', '');
      //     merchantTransactionId = merchantTransactionId.replaceAll('\\', '');

      //     log('payUrl------------>>   $payUrl');
      //     log('merchantTransactionId------------>>   $merchantTransactionId');
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return PhonepePaymentScreen(
      //         itemName: '',
      //         paymentType: 'wallet',
      //         paymentUrl: payUrl,
      //         amount: amount,
      //         merchantTransactionId: merchantTransactionId,
      //       );
      //     }));
      //     isPayLoading = false;
      //     notifyListeners();
      //   } else {

      //     showToast(msg:  msg,clr:  AppColoring.errorPopUp);
      //     isPayLoading = false;
      //     notifyListeners();
      //   }
      // });
    } catch (e) {
      isPayLoading = false;
      notifyListeners();
      log(e.toString());
      showToast(msg: 'Somwthing Wrong', clr: AppColoring.errorPopUp);
    }
    log('chech api login isPayLoading ----$isPayLoading');
  }

  Future<List<VerifyModelAddWallet>> checkWalletAddPaymnetverify(
      BuildContext context,
      {required String txId}) async {
    List<VerifyModelAddWallet> status = [];
    try {
      final userId = await LocalStorage.getUserUserIdSF();

      var parameter = {
        USERID: userId == null || userId == '' || userId.isEmpty ? '' : userId,

        //   TXID: txId
      };

      // await PhonePeRepo.walletAddCheckStatusrepo(parameter).then((value) {
      //   bool error = value['error'];
      //   //String? msg = value['message'];

      //   if (!error) {
      //     verifyPamentResponseData = value['status'];
      //     status = verifyPamentResponseData;
      //   } else {
      //     isPayLoading = false;
      //     notifyListeners();
      //   }
      // });
    } catch (e) {
      log(e.toString());
      // showToast(msg:  getTclr: ranslated(context, 'somethingMSg')!, context);
    }
    return status;
  }
}
