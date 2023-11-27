import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paystome/helper/api/api_headers.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/utility/dio_exception.dart';

class ApiException implements Exception {
  ApiException(this.errorMessage);

  String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}

class ApiBaseHelper {
  static Future<dynamic> postAPICall(
      String url, Map<String, dynamic> param) async {
    final headers = await ApiHeader.getHeaders();
    if (kDebugMode) {
      print(
          'response api****$url********$param*********StausCode:***********$headers');
    }
    final Dio dio = Dio();
    dynamic responseJson;
    try {
      final response = await dio
          .post(
            url,
            data: FormData.fromMap(param.isNotEmpty ? param : {}),
            //options: Options(headers: headers),
            // queryParameters: {
            //   'Content-type': 'application/json',
            // },
          )
          .timeout(
            const Duration(
              seconds: AppConstant.timeOut,
            ),
          );

      if (kDebugMode) {
        print(
            'response api****$url********$param*********StausCode:************${response.statusCode}***********  response   :${response.data}******************header****>>$headers');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = response.data; // No need for jsonDecode
        // log(responseJson.toString());
        return responseJson;
      } else {
        if (kDebugMode) {
          log(response.data.toString()); // Log the response data directly
        }
      }
    } catch (e) {
      print(e.toString());
      DioExceptionhandler.errorHandler(e);
    }
  }

  static Future<dynamic> postAPICallWithHeader(
      String url, Map<String, dynamic> param) async {
    final headers = await ApiHeader.getHeaders();
    if (kDebugMode) {
      print(
          'response api****$url********$param*********StausCode:***********$headers');
    }
    final Dio dio = Dio();
    dynamic responseJson;
    try {
      final response = await dio.post(
        url,
        data: FormData.fromMap(param.isNotEmpty ? param : {}),
        options: Options(headers: headers),
        queryParameters: {
          'Content-type': 'application/json',
        },
      ).timeout(
        const Duration(
          seconds: AppConstant.timeOut,
        ),
      );

      log('  response   :${response.data}');
      if (kDebugMode) {
        print(
            'response api****$url********$param*********StausCode:************${response.statusCode}***********  response   :${response.data}******************header****>>$headers');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = response.data; // No need for jsonDecode
        // log(responseJson.toString());
        return responseJson;
      } else {
        if (kDebugMode) {
          log(response.data.toString()); // Log the response data directly
        }
      }
    } catch (e) {
      log(e.toString());
      DioExceptionhandler.errorHandler(e);
    }
  }

  static Future<dynamic> getAPICall(
      String url, Map<String, dynamic> param) async {
    final headers = await ApiHeader.getHeaders();
    if (kDebugMode) {
      // log('response api****$url********$param*********StausCode:***********$headers');
    }
    final Dio dio = Dio();
    dynamic responseJson;
    try {
      final response = await dio
          .get(
            url,
            data: FormData.fromMap(param.isNotEmpty ? param : {}),
            options: Options(headers: headers),
          )
          .timeout(
            const Duration(
              seconds: AppConstant.timeOut,
            ),
          );

      if (kDebugMode) {
        print(
            'response api****$url********$param*********StausCode:******************header****>>$headers************${response.statusCode}***********  response   :${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = response.data; // No need for jsonDecode
        return responseJson;
      } else {
        if (kDebugMode) {
          log(response.data.toString()); // Log the response data directly
        }
      }
    } catch (e) {
      log(e.toString());
      DioExceptionhandler.errorHandler(e);
    }
  }

  static Future<dynamic> postAPICallWithDecode(
      String url, Map<String, dynamic> param) async {
    final headers = await ApiHeader.getHeaders();
    final Dio dio = Dio();
    dynamic responseJson;
    try {
      log('response api****$url********$param*********  response ');
      final response = await dio
          .post(
            url,
            data: FormData.fromMap(param.isNotEmpty ? param : {}),
            queryParameters: headers,
          )
          .timeout(
            const Duration(
              seconds: AppConstant.timeOut,
            ),
          );
      if (kDebugMode) {
        log('response api****$url********$param*********  response   :${response.data}******************');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = response.data;
        return responseJson;
      } else {
        if (kDebugMode) {
          print(response.data.toString());
        }
      }
    } catch (e) {
      print("Error occurred API CAll Classss: $e");
      DioExceptionhandler.errorHandler(e);
    }
  }
}
