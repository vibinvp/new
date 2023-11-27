import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Order/get_orders_model.dart';
import 'package:paystome/model/Order/invoice_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paystome/utility/dio_exception.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:open_filex/open_filex.dart';

class OrderController with ChangeNotifier {
  List<OrderList> orderList = [];
  GetOrderModel? orderModel;
  bool isLoadingGetOrder = false;
  Future<void> getOrders(BuildContext context) async {
    try {
      isLoadingGetOrder = true;
      notifyListeners();
      final userId = await LocalStorage.getUserUserIdSF();
      var paremeters = {
        USERID: userId,
      };
      await ApiBaseHelper.postAPICall(ApiEndPoint.getOrder, paremeters)
          .then((response) {
        if (response != null) {
          orderModel = GetOrderModel.fromJson(response);
          notifyListeners();
          if (orderModel != null && orderModel!.data != null) {
            notifyListeners();
            if (orderModel!.status == true) {
              List<OrderList> data = ((response['data']) as List)
                  .map((data) => OrderList.fromJson(data))
                  .toList();

              orderList = data;
              notifyListeners();

              isLoadingGetOrder = false;
              notifyListeners();
            } else {
              orderList = [];
              notifyListeners();
              isLoadingGetOrder = false;
              notifyListeners();
            }
          } else {
            orderList = [];
            notifyListeners();
            isLoadingGetOrder = false;
            notifyListeners();
          }
        } else {
          isLoadingGetOrder = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadingGetOrder = false;
      log("Error occurred products: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  ///--------------------------DownLoad PDF-------------------------------------///

  bool isDownloadInvoice = false;

  Future<void> generateAndDownloadPDF(String orderId, context) async {
    try {
      isDownloadInvoice = true;
      notifyListeners();

      var paremeters = {
        ORDERID: orderId,
      };
      final response = await ApiBaseHelper.postAPICall(
          ApiEndPoint.downloadInvoice, paremeters);

      if (response != null) {
        InvoicePdfModel ordersModel = InvoicePdfModel.fromJson(response);

        if (ordersModel.status == true) {
          var targetPath = await getApplicationDocumentsDirectory();
          var targetFileName = "Paystome Invoice";

          var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
              ordersModel.data ?? '', targetPath.path, targetFileName);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "CLICK HERE TO VIEW INVOICE",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColoring.kAppWhiteColor),
              ),
              action: SnackBarAction(
                label: 'View',
                textColor: AppColoring.kAppWhiteColor,
                onPressed: () async {
                  await OpenFilex.open(generatedPdfFile.path);
                  // launchUrl(Uri.parse(generatedPdfFile.path));
                },
              ),
              backgroundColor: AppColoring.successPopup,
            ),
          );

          isDownloadInvoice = false;
          notifyListeners();
        } else {
          isDownloadInvoice = false;
          notifyListeners();
        }
      } else {
        isDownloadInvoice = false;

        notifyListeners();
      }
    } catch (e) {
      isDownloadInvoice = false;
      print("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
