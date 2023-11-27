// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paystome/helper/api/api_headers.dart';
import 'package:paystome/helper/api/api_post_request.dart';
import 'package:paystome/helper/api/endpoint_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/core/string_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Authentication/message_response_model.dart';
import 'package:paystome/model/profile/bank_details_model.dart';
import 'package:paystome/model/profile/update_profile.dart';
import 'package:paystome/model/profile/user_details_model.dart';
import 'package:paystome/utility/dio_exception.dart';

import '../../view/Authentication/screen_signin.dart';

class ProfileController with ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();

  UserDetailsModel? userDetailsModel;
  BankDetailsModel? bankDetailsModel;
  UpdateProfileModel? updatemodel;
  MessageModel? submitBankModel;
  MessageModel? sndOtp;
  String profilePic = "";
  String? dropDownValueGender;
  File? image;
  bool enable = false;

  bool accountNumber = false;

  Future<void> getImage(ImageSource source) async {
    final pikImage = await ImagePicker().pickImage(
      source: source,
    );
    if (pikImage == null) {
      return;
    } else {
      final imageTemp = File(pikImage.path);
      image = imageTemp;

      notifyListeners();
      log("image picked  $image ");
    }
  }

  void changepasswodVisibility() {
    accountNumber = !accountNumber;
    notifyListeners();
  }

  void enableMap() {
    enable = true;
    notifyListeners();
  }

  void selectGender(String val) {
    dropDownValueGender = val;
    log(dropDownValueGender.toString());
    notifyListeners();
  }

  bool isLoadFetchUser = false;
  void getUserDetails(BuildContext context) async {
    try {
      isLoadFetchUser = true;
      notifyListeners();

      // var paremeters = {
      //   USERID: userId,
      // };

      await ApiBaseHelper.getAPICall(ApiEndPoint.getUser, {})
          .then((value) async {
        if (value != null) {
          userDetailsModel = UserDetailsModel.fromJson(value);
          if (userDetailsModel!.status == true) {
            userNameController.text = userDetailsModel!.data!.username ?? '';
            nameController.text = userDetailsModel!.data!.firstname ?? '';
            lastnameController.text = userDetailsModel!.data!.lastname ?? '';
            emailController.text = userDetailsModel!.data!.email ?? '';
            mobileController.text = userDetailsModel!.data!.mobile ?? '';
            pincodeController.text = userDetailsModel!.data!.uzip ?? '';
            stateController.text = userDetailsModel!.data!.state ?? '';
            cityController.text = userDetailsModel!.data!.ucity ?? '';
            addressController.text = userDetailsModel!.data!.address1 ?? '';

            dropDownValueGender = null;
            profilePic = userDetailsModel!.data!.profileImage ?? '';
            if (addressController.text != '' ||
                addressController.text.isNotEmpty) {
              enable = true;
            }

            isLoadFetchUser = false;
            notifyListeners();
            await LocalStorage.saveUserEmailSF(
                userDetailsModel!.data!.email ?? '');
            await LocalStorage.saveNameSF(
                userDetailsModel!.data!.firstname ?? '');
            await LocalStorage.saveUserLastNameSF(
                userDetailsModel!.data!.lastname ?? '');
            await LocalStorage.saveUserPPSF(
                userDetailsModel!.data!.profileImage.toString());
            await LocalStorage.saveUserMobileSF(
                userDetailsModel!.data!.mobile.toString());
            // await LocalStorage.saveUserUserIdSF(
            //     userDetailsModel!.data!.userId ?? '');
          } else {
            isLoadFetchUser = false;
            notifyListeners();
          }
        } else {
          isLoadFetchUser = false;
          notifyListeners();
        }
      });
    } catch (e) {
      DioExceptionhandler.errorHandler(e);
    }
  }

  bool isLoadUpdateUser = false;
  void updateUser(BuildContext context) async {
    try {
      isLoadUpdateUser = true;
      notifyListeners();

      String imagePath = image?.path ?? '';
      log('$imagePath  ----------');
      Dio dio = Dio();
      final password = await LocalStorage.getUserpasswordSF();
      //final username = await LocalStorage.getUserNameFromSF();
      final headers = await ApiHeader.getHeaders();

      FormData formData = FormData.fromMap({
        USERNAME: userNameController.text,
        FIRSTNAME: nameController.text,
        LASTNAME: lastnameController.text,
        EMAIL: emailController.text,
        PASSWORD: password,
        CONFPASSWORD: password,
        DEVICETYPE: DeviceType.getPlatform(),
        DEVICETOKEN: '1',
        CUNTRYID: '+91',
        UZIP: pincodeController.text,
        STATE: stateController.text,
        ADDRESS1: addressController.text,
        UCITY: cityController.text,
        MOBILE: mobileController.text,
        AVATHAR: imagePath.isEmpty
            ? ''
            : await MultipartFile.fromFile(
                imagePath,
                filename: imagePath
                    .split('/')
                    .last, // Use the last part of the path as filename
              ),
      });

      await dio.post(
        ApiEndPoint.updateProfile,
        data: formData,
        options: Options(headers: headers),
        queryParameters: {
          'Content-type': 'application/json',
          //   'Authorization':
          //       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IjIwMjMtMDgtMjggMTI6MjU6MjI4MDg2Njg5MTg0Ig.P2hiVug5fkkQhGo9wGCnAi-gni7wsidrGPysMI83QPw',
        },
      ).then((value) async {
        //     });

        // await ApiBaseHelper.postAPICall(ApiEndPoint.updateProfile, paremeters)
        //     .then((value) async {
        updatemodel = UpdateProfileModel.fromJson(value.data);

        if (updatemodel != null) {
          if (updatemodel!.status == true) {
            showToast(
                msg: updatemodel!.message ?? '', clr: AppColoring.successPopup);

            await LocalStorage.saveUserEmailSF(
                updatemodel!.data!.email.toString());

            await LocalStorage.saveNameSF(
                updatemodel!.data!.firstname.toString());
            await LocalStorage.saveUserLastNameSF(
                updatemodel!.data!.lastname.toString());

            await LocalStorage.saveUserNameSF(
                updatemodel!.data!.username.toString());
            await LocalStorage.saveUserMobileSF(
                updatemodel!.data!.phone.toString());

            isLoadUpdateUser = false;
            notifyListeners();
            getUserDetails(context);
          } else {
            showToast(
                msg: updatemodel!.message ?? '', clr: AppColoring.errorPopUp);
            isLoadUpdateUser = false;
            notifyListeners();
          }
        }
      });
    } catch (e) {
      log(e.toString());
      isLoadUpdateUser = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    } finally {}
  }

  //////////////---------------------Logout----------------------------///

  void appLogOut(BuildContext context) async {
    await LocalStorage.saveUserLoggedInStatus('false');
    await LocalStorage.saveUserEmailSF("");
    await LocalStorage.saveNameSF("");
    await LocalStorage.saveUserUserIdSF("");
    await LocalStorage.saveUserNameSF("");
    await LocalStorage.saveUserMobileSF("");
    await LocalStorage.saveUserAddressSF("");
    await LocalStorage.saveUserPPSF("");
    await LocalStorage.saveUserCitySF("");
    await LocalStorage.saveUserLatSF("");
    await LocalStorage.saveUserLngSF("");
    await LocalStorage.saveUserSexSF("");
    await LocalStorage.saveUserPincodeSF("");
    await LocalStorage.saveUserPPSF("");

    notifyListeners();
    RouteConstat.nextRemoveUntileNamed(context, const ScreenSignIn());
    showToast(msg: "Logout Successfully", clr: Colors.green);
    notifyListeners();
  }

  bool isLoadSubmitDetails = false;

  Future<void> submitBankDetails({
    required BuildContext context,
    required String otp,
  }) async {
    try {
      isLoadSubmitDetails = true;
      notifyListeners();

      final userId = await LocalStorage.getUserUserIdSF();

      var paremeters = {
        USERID: userId,
        PAYMENTBANKNAME: bankNameController.text,
        PAYMENTHOLDERNAME: holderNameController.text,
        PAYMENTACCOUTNUMBER: accountNumberController.text,
        PAYMENTBANKIFSCCODE: ifscCodeController.text,
        OTP: otp,
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.submitBankDetails, paremeters)
          .then((value) {
        if (value != null) {
          submitBankModel = MessageModel.fromJson(value);
          if (submitBankModel!.status == true) {
            showToast(
                msg: submitBankModel!.message ?? '',
                clr: AppColoring.successPopup);
            getBankDetails(context);
            RouteConstat.back(context);

            isLoadSubmitDetails = false;
            notifyListeners();
          } else {
            showToast(
                msg: submitBankModel!.message ?? '',
                clr: AppColoring.errorPopUp);
            //  / RouteConstat.back(context);
            isLoadSubmitDetails = false;
            notifyListeners();
          }
        } else {
          isLoadSubmitDetails = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadSubmitDetails = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
  }

  bool isLoadingGetBankDetilas = false;
  void getBankDetails(BuildContext context) async {
    try {
      isLoadingGetBankDetilas = true;
      notifyListeners();
      final userId = await LocalStorage.getUserUserIdSF();

      var paremeters = {
        USERID: userId,
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.getBankDetails, paremeters)
          .then((value) async {
        if (value != null) {
          bankDetailsModel = BankDetailsModel.fromJson(value);
          if (bankDetailsModel!.status == true) {
            bankNameController.text =
                bankDetailsModel!.data![0].paymentBankName ?? '';
            holderNameController.text =
                bankDetailsModel!.data![0].paymentAccountName ?? '';
            accountNumberController.text =
                bankDetailsModel!.data![0].paymentAccountNumber ?? '';
            ifscCodeController.text =
                bankDetailsModel!.data![0].paymentIfscCode ?? '';
          } else {
            isLoadingGetBankDetilas = false;
            notifyListeners();
          }
        } else {
          isLoadingGetBankDetilas = false;
          notifyListeners();
        }
      });
    } catch (e) {
      DioExceptionhandler.errorHandler(e);
    }
  }

  bool isLoadSndOtp = false;
  Future<bool> sndotpUpdateBankDetails(
    BuildContext context,
  ) async {
    bool check = false;
    notifyListeners();
    try {
      isLoadSndOtp = true;
      notifyListeners();

      final userId = await LocalStorage.getUserUserIdSF();

      var paremeters = {
        USERID: userId,
      };

      await ApiBaseHelper.postAPICall(ApiEndPoint.usersndOtp, paremeters)
          .then((value) {
        sndOtp = MessageModel.fromJson(value);
        if (sndOtp != null) {
          if (sndOtp!.status == true) {
            showToast(
                msg: sndOtp!.message ?? '', clr: AppColoring.successPopup);
            check = true;
            notifyListeners();
            isLoadSndOtp = false;
            notifyListeners();
          } else {
            showToast(msg: sndOtp!.message ?? '', clr: AppColoring.errorPopUp);
            isLoadSndOtp = false;
            notifyListeners();
          }
        } else {
          isLoadSndOtp = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoadSndOtp = false;
      notifyListeners();
      DioExceptionhandler.errorHandler(e);
    }
    return check;
  }
}
