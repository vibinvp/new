import 'dart:io';

import 'package:paystome/helper/storage/local_storage.dart';

class ApiHeader {
  static Future<Map<String, String>> getHeaders() async {
    final token = await getToken();

    return {
      'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': token.toString(),
    };
  }

  static Future<String?> getToken() async {
    final token = await LocalStorage.getUserAuthTokenSF();
    return token;
  }
}

class DeviceType {
  static num getPlatform() {
    num patfomm = 1;
    if (Platform.isAndroid) {
      patfomm = 1;
    } else if (Platform.isIOS) {
      patfomm = 1;
    }

    return patfomm;
  }
}
