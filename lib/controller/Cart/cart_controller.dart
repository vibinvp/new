import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Authentication/message_response_model.dart';
import 'package:paystome/model/Cart/get_cart_model.dart';
import 'package:paystome/utility/dio_exception.dart';
import 'package:paystome/view/cart/screen_cart.dart';

class CartController with ChangeNotifier {
  MessageModel? model;
  bool isLoadaddToCart = false;
  bool isLoadingGetCart = false;
  bool isLoadingdeleteCart = false;
  GetCartModel? getCartModel;
  MessageModel? messageModel;
  List<CartItem> cartItemList = [];
  String totalAmount = '0';

  void addToCartProduct(BuildContext context,
      {required String productId, required String type}) async {
    final userId = await LocalStorage.getUserUserIdSF();
    final refId = await LocalStorage.getUserRefferalSF();
    try {
      isLoadaddToCart = true;
      notifyListeners();

      var paremeters = {
        PRODUCTID: productId.toString(),
        USERID: userId.toString(),
        QUANDITY: '1',
        REFID: refId.toString(),
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.addToCart, paremeters)
          .then((value) async {
        model = MessageModel.fromJson(value);
        if (model != null) {
          if (model!.status == true) {
            showToast(msg: model!.message ?? '', clr: AppColoring.successPopup);
            isLoadaddToCart = false;
            notifyListeners();
            if (type == 'buy') {
              RouteConstat.nextNamed(context, const ScreenCart());
            }
          } else {
            showToast(msg: model!.message ?? '', clr: AppColoring.errorPopUp);
            isLoadaddToCart = false;
            notifyListeners();
          }
        } else {
          showToast(msg: model!.message ?? '', clr: AppColoring.errorPopUp);
          isLoadaddToCart = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadaddToCart = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  Future<void> getCartItems(BuildContext context) async {
    try {
      isLoadingGetCart = true;
      notifyListeners();
      final userId = await LocalStorage.getUserUserIdSF();
      var paremeters = {
        USERID: userId,
      };
      await ApiBaseHelper.postAPICall(ApiEndPoint.getCart, paremeters)
          .then((response) {
        if (response != null) {
          getCartModel = GetCartModel.fromJson(response);
          notifyListeners();
          if (getCartModel != null && getCartModel!.data != null) {
            totalAmount = getCartModel!.total ?? '0';

            notifyListeners();
            if (getCartModel!.status == true) {
              List<CartItem> data = ((response['data']) as List)
                  .map((data) => CartItem.fromJson(data))
                  .toList();

              cartItemList = data;
              notifyListeners();
              

              isLoadingGetCart = false;
              notifyListeners();
            } else {
              cartItemList = [];
              notifyListeners();
              isLoadingGetCart = false;
              notifyListeners();
            }
          } else {
            cartItemList = [];
            totalAmount = '0';
            notifyListeners();
            isLoadingGetCart = false;
            notifyListeners();
          }
        } else {
          isLoadingGetCart = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadingGetCart = false;
      log("Error occurred products: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  Future<void> deleteCartItem(BuildContext context,
      {required String cartId}) async {
    try {
      isLoadingdeleteCart = true;
      notifyListeners();
      var paremeters = {
        CARTID: cartId,
      };
      await ApiBaseHelper.postAPICall(ApiEndPoint.deleteCart, paremeters)
          .then((response) {
        if (response != null) {
          messageModel = MessageModel.fromJson(response);
          notifyListeners();
          if (messageModel != null) {
            if (messageModel!.status == true) {
              showToast(
                  msg: messageModel!.message.toString(),
                  clr: AppColoring.successPopup);

              notifyListeners();
              getCartItems(context);

              isLoadingdeleteCart = false;
              notifyListeners();
            } else {
              showToast(
                  msg: messageModel!.message.toString(),
                  clr: AppColoring.errorPopUp);
              isLoadingdeleteCart = false;
              notifyListeners();
            }
          } else {
            isLoadingdeleteCart = false;
            notifyListeners();
          }
        } else {
          isLoadingdeleteCart = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadingdeleteCart = false;
      log("Error occurred products: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
