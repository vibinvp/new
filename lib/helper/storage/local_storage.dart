

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  //keys
  static String userLoggedinKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userLastNameKey = "USERLASTNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userMoileKey = "USERMOBILEKEY";
  static String userIdInKey = "LOGGEDUSERIDKEY";
  static String userRefferalKey = "USERRREFERALKEY";
  static String userAuthToken = "AUTHTOKEN";
  static String userAddressKey = "USERADDRESSKEY";
  static String userCityKey = "USERCITYKEY";
  static String userPPInKey = "LOGGEDPPKEY";
  static String userPasswordKey = "USERPASSWORDKEY";
  static String userlatKey = "USERLATKEY";
  static String userlagKey = "USERELNGKEY";
  static String userSexKey = "USERESEXKEY";
  static String userStateKey = "USERESTATEKEY";
  static String userPincodeKey = "USEREPINCODEKEY";
  static String nameKey = "NAMEKEY";
  static String selectedService = "SELECTEDSERVICE";

  // saving the data to SF

  static Future<void> saveUserLoggedInStatus(String isUserLoggedIn) async {
    storage.write(key: userLoggedinKey, value: isUserLoggedIn);
  }

  static Future<void> saveUserNameSF(String userName) async {
    return await storage.write(key: userNameKey, value: userName);
  }

  static Future<void> saveNameSF(String name) async {
    return await storage.write(key: nameKey, value: name);
  }

  static Future<void> saveUserEmailSF(String userEmail) async {
    return await storage.write(key: userEmailKey, value: userEmail);
  }
  static Future<void> saveUserMobileSF(String mobile) async {
    return await storage.write(key: userMoileKey, value: mobile);
  }

  static Future<void> saveUserUserIdSF(String userId) async {
    return await storage.write(key: userIdInKey, value: userId);
  }

  static Future<void> saveUserRefferalIdSF(String refId) async {
    return await storage.write(key: userRefferalKey, value: refId);
  }

  static Future<void> saveUserAuthenticationTokenSF(String userId) async {
    return await storage.write(key: userAuthToken, value: userId);
  }

  static Future<void> saveUserAddressSF(String userAdress) async {
    return await storage.write(key: userAddressKey, value: userAdress);
  }

  static Future<void> saveUserLastNameSF(String userAdress) async {
    return await storage.write(key: userLastNameKey, value: userAdress);
  }

  static Future<void> saveUserCitySF(String userCity) async {
    return await storage.write(key: userCityKey, value: userCity);
  }

  static Future<void> saveUserPPSF(String userPP) async {
    return await storage.write(key: userPPInKey, value: userPP);
  }

  static Future<void> saveUserPasswordSF(String userPP) async {
    return await storage.write(key: userPasswordKey, value: userPP);
  }

  static Future<void> saveUserLatSF(String userLat) async {
    return await storage.write(key: userlatKey, value: userLat);
  }

  static Future<void> saveUserLngSF(String userLag) async {
    return await storage.write(key: userlagKey, value: userLag);
  }

  static Future<void> saveUserSexSF(String userSex) async {
    return await storage.write(key: userSexKey, value: userSex);
  }

  static Future<void> saveUserStateInSF(String userState) async {
    return await storage.write(key: userStateKey, value: userState);
  }

  static Future<void> saveUserPincodeSF(String userPincode) async {
    return await storage.write(key: userPincodeKey, value: userPincode);
  }

  // getting the data from SF

  static Future<String?> getUserLoggedInStatus() async {
    return storage.read(key: userLoggedinKey);
  }

  static Future<String?> getNameSF() async {
    return storage.read(key: nameKey);
  }

  static Future<String?> getLastNameSF() async {
    return storage.read(key: userLastNameKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    return storage.read(key: userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    return storage.read(key: userNameKey);
  }
  static Future<String?> getUserMobileFromSF() async {
    return storage.read(key: userMoileKey);
  }

  static Future<String?> getUserUserIdSF() async {
    return storage.read(key: userIdInKey);
  }

  static Future<String?> getUserAuthTokenSF() async {
    return storage.read(key: userAuthToken);
  }

  static Future<String?> getUserAddressSF() async {
    return storage.read(key: userAddressKey);
  }

  static Future<String?> getUserCitySF() async {
    return storage.read(key: userCityKey);
  }

  static Future<String?> getUserPPSF() async {
    return storage.read(key: userPPInKey);
  }

  static Future<String?> getUserLatSF() async {
    return storage.read(key: userlatKey);
  }

  static Future<String?> getUserLngSF() async {
    return storage.read(key: userlagKey);
  }

  static Future<String?> getUserSexSF() async {
    return storage.read(key: userSexKey);
  }

  static Future<String?> getUserStateInSF() async {
    return storage.read(key: userStateKey);
  }

  static Future<String?> getUserPincodeSF() async {
    return storage.read(key: userPincodeKey);
  }

  static Future<String?> getUserpasswordSF() async {
    return storage.read(key: userPasswordKey);
  }

  static Future<String?> getUserRefferalSF() async {
    return storage.read(key: userRefferalKey);
  }

  static Future<List<String>?> getServiceList() async {
    final encodedList = await storage.read(
      key: selectedService,
    );
    if (encodedList != null) {
      final newList = encodedList.split(',');
      return newList;
    }
    return null;
  }
}
