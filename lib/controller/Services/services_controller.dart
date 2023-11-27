import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Authentication/message_response_model.dart';
import 'package:paystome/model/Services/service_details.dart';
import 'package:paystome/utility/dio_exception.dart';

class ServiceController with ChangeNotifier {
  GetPerodectsModel? homeBookings;
  List<ProductsData> videoList = [];
  bool isLoadHomeService = false;
  MessageModel? messageModel;

  void getvideeosList(
      BuildContext context, String offset, String cateId) async {
    try {
      if (offset == '0') {
        isLoadHomeService = true;
        notifyListeners();
      }
      var paremeters = {
        LIMIT: AppConstant.perPage,
        OFFSET: offset,
        CATEGORYID: cateId
      };
      final response = await ApiBaseHelper.postAPICall(
          ApiEndPoint.getCategoyrServices, paremeters);

      if (response != null) {
        homeBookings = GetPerodectsModel.fromJson(response);

        if (homeBookings != null && homeBookings!.data != null) {
          if (homeBookings!.status == true) {
            List<ProductsData> data = ((response['data']) as List)
                .map((data) => ProductsData.fromJson(data))
                .toList();
            if (offset != '0') {
              videoList.addAll(data);
            } else {
              videoList = data;
            }

            isLoadHomeService = false;
            notifyListeners();
          } else {
            //  videoList = [];
            isLoadHomeService = false;
            notifyListeners();
          }
        } else {
          isLoadHomeService = false;
          notifyListeners();
        }
      } else {
        isLoadHomeService = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadHomeService = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  //-----------------------CHECK PURCHASED OR NOT---------------------------------//

  bool isLoadCheckPrchase = false;
  Future<bool> isPurshasedVideo(BuildContext context,
      {required String pId}) async {
    bool check = false;
    notifyListeners();
    try {
      isLoadCheckPrchase = true;
      notifyListeners();
      final userId = await LocalStorage.getUserUserIdSF();

      var paremeters = {
        USERID: userId,
        PRODUCTID: pId,
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.checkPurchase, paremeters)
          .then((value) {
        messageModel = MessageModel.fromJson(value);
        if (messageModel != null) {
          if (messageModel!.status == true) {
            showToast(
                msg: messageModel!.message ?? '',
                clr: AppColoring.successPopup);
            check = true;
            notifyListeners();
            isLoadCheckPrchase = false;
            notifyListeners();
          } else {
            // showToast(
            //     msg: messageModel!.message ?? '', clr: AppColoring.errorPopUp);
            isLoadCheckPrchase = false;
            notifyListeners();
          }
        } else {
          isLoadCheckPrchase = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadCheckPrchase = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
    return check;
  }
}
