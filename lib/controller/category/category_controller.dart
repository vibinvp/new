// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/model/Category/get_category_model.dart';
import 'package:paystome/utility/dio_exception.dart';

class CategoryController with ChangeNotifier {
  List<CategoryData> categoryList = [];
  GetCategoryModel? categoryModel;
  bool isLoadCategory = false;

  void getcategoryList(BuildContext context) async {
    try {
      isLoadCategory = true;
      notifyListeners();

      var paremeters = {
        BOOKINGTYPE: '2',
      };

      final response =
          await ApiBaseHelper.getAPICall(ApiEndPoint.getCategory, paremeters);

      if (response != null) {
        categoryModel = GetCategoryModel.fromJson(response);
        if (categoryModel != null && categoryModel!.data != null) {
          categoryList = ((response['data']) as List)
              .map((data) => CategoryData.fromJson(data))
              .toList();

          isLoadCategory = false;
          notifyListeners();
        } else {
          isLoadCategory = false;

          notifyListeners();
        }
      } else {
        isLoadCategory = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadCategory = false;
      log("Error occurred category: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
