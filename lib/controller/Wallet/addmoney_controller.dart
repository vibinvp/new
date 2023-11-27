import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/model/Authentication/message_response_model.dart';
import 'package:paystome/model/membership/plan_model.dart';
import 'package:paystome/utility/dio_exception.dart';

class PlanController with ChangeNotifier {
  bool isLoadFetchPlan = false;
  MembershipPlansModel? plansModel;
  MessageModel? messageModel;
  List<PlanData> planList = [];

  void getPlanDetails(BuildContext context, String offset) async {
    try {
      isLoadFetchPlan = true;
      notifyListeners();

      final response =
          await ApiBaseHelper.getAPICall(ApiEndPoint.getMembershipPlan, {});

      if (response != null) {
        plansModel = MembershipPlansModel.fromJson(response);

        if (plansModel != null && plansModel!.data != null) {
          if (plansModel!.status == true) {
            List<PlanData> data = ((response['data']['plans']) as List)
                .map((data) => PlanData.fromJson(data))
                .toList();
            planList = data;

            isLoadFetchPlan = false;
            notifyListeners();
          } else {
            isLoadFetchPlan = false;
            notifyListeners();
          }
        } else {
          isLoadFetchPlan = false;

          notifyListeners();
        }
      } else {
        isLoadFetchPlan = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadFetchPlan = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  // bool isLoadgetByPlan = false;

  // void puchasePlan(BuildContext context, String planId) async {
  //   try {
  //     isLoadgetByPlan = true;
  //     notifyListeners();

  //     final userId = await LocalStorage.getUserUserIdSF();

  //     var paremeters = {
  //       USERID: userId,
  //      // PLANID: planId,
  //     };
  //     final response =
  //         await ApiBaseHelper.postAPICall(ApiEndPoint.planPurchase, paremeters);

  //     if (response != null) {
  //       messageModel = MessageModel.fromJson(response);

  //       if (messageModel != null) {
  //         if (messageModel!.status == true) {
  //           showToast(
  //               msg: messageModel!.message ?? '',
  //               clr: AppColoring.successPopup);
  //           context.read<ProfileController>().getUserDetails(context);
  //           RouteConstat.nextRemoveUntileNamed(context, DashboardScreen());
  //           context.read<DashboardController>().bottomShift(1);

  //           isLoadgetByPlan = false;
  //           notifyListeners();
  //         } else {
  //           showToast(
  //               msg: messageModel!.message ?? '', clr: AppColoring.errorPopUp);
  //           isLoadgetByPlan = false;
  //           notifyListeners();
  //           RouteConstat.back(context);
  //         }
  //       } else {
  //         isLoadgetByPlan = false;

  //         notifyListeners();
  //       }
  //     } else {
  //       isLoadgetByPlan = false;

  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     isLoadgetByPlan = false;
  //     log("Error occurred: $e");
  //     notifyListeners();
  //     DioExceptionhandler.errorHandler(e);
  //   }
  // }
}
