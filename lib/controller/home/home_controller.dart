// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Category/get_category_model.dart';
import 'package:paystome/model/Services/service_details.dart';
import 'package:paystome/model/home/banner_model.dart';
import 'package:paystome/utility/dio_exception.dart';

class HomeController with ChangeNotifier {
  GetBannersModel? getBannersModel1;
  List<BannerData> banner = [];
  String name = '';
  String earnings = '';
  int selectedSliderIndex = 0;
  GetPerodectsModel? searchModel;
  List<ProductsData> searchList = [];

  Future<void> getUserdata() async {
    final String? firstname = await LocalStorage.getNameSF();
    final String? lastname = await LocalStorage.getLastNameSF();
    earnings = '200';
    name = '$firstname $lastname';
    log('$firstname $lastname');
  }

  void changeSliderIndex(int index) {
    selectedSliderIndex = index;
    notifyListeners();
  }

  bool isLoadBannner = false;

  void getBanners(BuildContext context) async {
    try {
      isLoadBannner = true;
      notifyListeners();

      final response = await ApiBaseHelper.postAPICall(ApiEndPoint.banner, {});

      if (response != null) {
        getBannersModel1 = GetBannersModel.fromJson(response);
        if (getBannersModel1 != null && getBannersModel1!.data != null) {
          banner = ((response['data']) as List)
              .map((data) => BannerData.fromJson(data))
              .toList();
          isLoadBannner = false;
          notifyListeners();
        } else {
          isLoadBannner = false;

          notifyListeners();
        }
      } else {
        isLoadBannner = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadBannner = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  bool isLoadingSearch = false;

  List<CategoryData> categoryList = [];
  List<ProductsData> categoryProducts1List = [];
  List<ProductsData> categoryProducts2List = [];
  List<ProductsData> categoryProducts3List = [];
  GetCategoryModel? categoryModel;
  bool isLoadCategory = false;

  void getcategoryList(BuildContext context) async {
    try {
      isLoadCategory = true;
      notifyListeners();

      final response =
          await ApiBaseHelper.getAPICall(ApiEndPoint.getCategory, {});

      if (response != null) {
        categoryModel = GetCategoryModel.fromJson(response);
        if (categoryModel != null && categoryModel!.data != null) {
          categoryList = ((response['data']) as List)
              .map((data) => CategoryData.fromJson(data))
              .toList();

          if (categoryList.isNotEmpty) {
            await getcategoryProductsList(context, categoryList[0].id ?? '')
                .then((value) {
              categoryProducts1List = value ?? [];
              notifyListeners();

              log('Category Prodtct  length 1 --------------->>>>  ${categoryProducts1List.length}');
            });

            if (categoryList.length >= 2) {
              await getcategoryProductsList(context, categoryList[1].id ?? '')
                  .then((value) {
                categoryProducts2List = value ?? [];
                notifyListeners();
                log('Category Prodtct  length 2 --------------->>>>  ${categoryProducts1List.length}');
              });
            }
            if (categoryList.length >= 3) {
              await getcategoryProductsList(context, categoryList[2].id ?? '')
                  .then((value) {
                categoryProducts3List = value ?? [];
                notifyListeners();
                log('Category Prodtct  length 3 --------------->>>>  ${categoryProducts1List.length}');
              });
            }
          }
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

  Future<List<ProductsData>?> getcategoryProductsList(
      BuildContext context, String catId) async {
    try {
      var paremeters = {
        CATEGORYID: catId,
        LIMIT: '5',
        OFFSET: '0',
      };

      final response = await ApiBaseHelper.postAPICall(
          ApiEndPoint.getCategoyrServices, paremeters);

      if (response != null) {
        GetPerodectsModel productmodel = GetPerodectsModel.fromJson(response);

        if (productmodel.data != null && productmodel.data!.isNotEmpty) {
          var productsList = ((response['data']) as List)
              .map((data) => ProductsData.fromJson(data))
              .toList();

          notifyListeners();
          return productsList;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      isLoadCategory = false;
      log("Error occurred products: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
    return [];
  }

  void searchServices(
    BuildContext context,
    String searchText,
  ) async {
    try {
      isLoadingSearch = true;
      notifyListeners();
      var paremeters = {
        SEARCH: searchText,
      };
      final response = await ApiBaseHelper.postAPICall(
          ApiEndPoint.searchProduct, paremeters);

      if (response != null) {
        searchModel = GetPerodectsModel.fromJson(response);
        if (searchModel != null && searchModel!.data != null) {
          if (searchModel!.status == true) {
            List<ProductsData> data = ((response['data']) as List)
                .map((data) => ProductsData.fromJson(data))
                .toList();

            searchList = data;

            isLoadingSearch = false;
            notifyListeners();
          } else {
            searchList = [];
            isLoadingSearch = false;
            notifyListeners();
          }
        } else {
          isLoadingSearch = false;
          notifyListeners();
        }
      } else {
        isLoadingSearch = false;

        notifyListeners();
      }
    } catch (e) {
      isLoadingSearch = false;
      log("Error occurred: $e");
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }
}
