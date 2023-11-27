import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Authentication/message_response_model.dart';
import 'package:paystome/model/wallet/transaction_model.dart';
import 'package:paystome/model/wallet/wallet_model.dart';
import 'package:paystome/model/wallet/withdraw_request_model.dart';
// import 'package:paystome/model/Wallet/transaction_model.dart';
import 'package:paystome/utility/dio_exception.dart';

class WalletController with ChangeNotifier {
  TextEditingController requestAmountController = TextEditingController();
  TextEditingController requestNoteController = TextEditingController();

  WalletTransactionModel? walletTransactionModel;
  WithdrawRequestModel? withdrawRequestModel;
  WalletModel? walletModel;
  MessageModel? sendRequestModel;
  List<TransactionData> transactionList = [];
  List<RequestList> withdrawRequestList = [];
  bool isLoadgetWalletTransactions = false;
  bool isLoadgetwithdrawRequest = false;
  bool isLoadgetWallet = false;

  void getWalletTransactions(BuildContext context, String offset) async {
    try {
      if (offset == '0') {
        isLoadgetWalletTransactions = true;
        notifyListeners();
      }
      final userId = await LocalStorage.getUserUserIdSF();

      var paremeters = {
        USERID: userId,
        LIMIT: AppConstant.perPage,
        OFFSET: offset,
      };
      final response = await ApiBaseHelper.postAPICall(
          ApiEndPoint.walletTransactions, paremeters);

      if (response != null) {
        walletTransactionModel = WalletTransactionModel.fromJson(response);

        if (walletTransactionModel != null &&
            walletTransactionModel!.data != null) {
          if (walletTransactionModel!.status == true) {
            List<TransactionData> data = ((response['data']) as List)
                .map((data) => TransactionData.fromJson(data))
                .toList();
            // if (offset != '0') {
            //   completeOrderList.addAll(data);
            // } else {
            transactionList = data;
          } else {
            transactionList = [];
            notifyListeners();
          }

          isLoadgetWalletTransactions = false;
          notifyListeners();
        } else {
          isLoadgetWalletTransactions = false;
          notifyListeners();
        }
      } else {
        isLoadgetWalletTransactions = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadgetWalletTransactions = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  void getWallet() async {
    try {
      isLoadgetWallet = true;
      notifyListeners();

      // final userId = await LocalStorage.getUserUserIdSF();

      // var paremeters = {
      //   USERID: userId,
      // };
      final response =
          await ApiBaseHelper.getAPICall(ApiEndPoint.getWallet, {});

      if (response != null) {
        walletModel = WalletModel.fromJson(response);

        notifyListeners();
        isLoadgetWallet = false;
      } else {
        walletModel = WalletModel.fromJson({});

        isLoadgetWallet = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadgetWallet = false;
      if (kDebugMode) {
        print("refferal----------->> Error occurred category: $e");
      }
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  void getWithdrawRequest(BuildContext context, String offset) async {
    try {
      isLoadgetwithdrawRequest = true;
      notifyListeners();

      // final userId = await LocalStorage.getUserUserIdSF();

      // var paremeters = {
      //   USERID: userId,
      //   LIMIT: AppConstant.perPage,
      //   OFFSET: offset,
      // };
      final response =
          await ApiBaseHelper.getAPICall(ApiEndPoint.withdrawRequestList, {});

      if (response != null) {
        withdrawRequestModel = WithdrawRequestModel.fromJson(response);

        if (withdrawRequestModel != null &&
            withdrawRequestModel!.data != null) {
          if (withdrawRequestModel!.status == true) {
            List<RequestList> data = ((response['data']['list']) as List)
                .map((data) => RequestList.fromJson(data))
                .toList();

            withdrawRequestList = data;
          } else {
            withdrawRequestList = [];
            notifyListeners();
          }

          isLoadgetwithdrawRequest = false;
          notifyListeners();
        } else {
          isLoadgetwithdrawRequest = false;
          notifyListeners();
        }
      } else {
        isLoadgetwithdrawRequest = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadgetwithdrawRequest = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  bool sendRequest = false;

  void sendWithdrawRequest() async {
    try {
      sendRequest = true;
      notifyListeners();

      // final userId = await LocalStorage.getUserUserIdSF();

      // var paremeters = {
      //   USERID: userId,
      // };
      await ApiBaseHelper.postAPICallWithHeader(
          ApiEndPoint.sendWithdrawRequest, {}).then((value) {
        sendRequestModel = MessageModel.fromJson(value);
        if (sendRequestModel != null) {
          if (sendRequestModel!.status == true) {
            showToast(
                msg: sendRequestModel!.message ?? '',
                clr: AppColoring.successPopup);

            notifyListeners();
            sendRequest = false;
            notifyListeners();
          } else {
            showToast(
                msg: sendRequestModel!.message ?? '',
                clr: AppColoring.errorPopUp);
            sendRequest = false;
            notifyListeners();
          }
        } else {
          sendRequest = false;
          notifyListeners();
        }
      });
    } catch (e) {
      sendRequest = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
