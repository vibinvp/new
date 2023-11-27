import 'package:paystome/helper/api/base_constatnt.dart';

class ApiEndPoint {
  static const String userLogin = '${ApiBaseConstant.baseUrl}User/login';
  static const String usersndOtp = '${ApiBaseConstant.baseUrlAPI}sent_otp';
  // static const String userRegister =
  //     '${ApiBaseConstant.baseUrl}User/registarion';

  static const String userRegister = '${ApiBaseConstant.baseUrlAPI}register';
  static const String forgotPassword =
      '${ApiBaseConstant.baseUrlAPI}forgot__password';

  static const String getUser =
      '${ApiBaseConstant.baseUrl}User/get_my_profile_details';
  static const String updateProfile =
      '${ApiBaseConstant.baseUrl}User/update_my_profile';
  static const String banner = '${ApiBaseConstant.baseUrlAPI}banners';
  static const String walletTransactions =
      '${ApiBaseConstant.baseUrlAPI}wallet_trans';
  static const String withdrawRequestList =
      '${ApiBaseConstant.baseUrl}Withdraw_Request/withdraw_request_list';
  static const String sendWithdrawRequest =
      '${ApiBaseConstant.baseUrl}Withdraw_Request/send_withdraw_request';
  static const String getWallet =
      '${ApiBaseConstant.baseUrl}User/dashboard?includes=totals_count';
  static const String getMembershipPlan =
      '${ApiBaseConstant.baseUrl}Subscription_Plan/get_membership_plan';
  static const String addToCart = '${ApiBaseConstant.baseUrlAPI}add_to_cart';
  static const String getCart = '${ApiBaseConstant.baseUrlAPI}get_cart';
  static const String deleteCart = '${ApiBaseConstant.baseUrlAPI}delete_cart';
  static const String placeOrder = '${ApiBaseConstant.baseUrlAPI}check_out';
  static const String submitBankDetails =
      '${ApiBaseConstant.baseUrlAPI}payment_details';
  static const String getBankDetails =
      '${ApiBaseConstant.baseUrlAPI}get_payment_detials';
  static const String getOrder = '${ApiBaseConstant.baseUrlAPI}get_order';
  static const String getCategory =
      '${ApiBaseConstant.baseUrl}Store_Category/get_store_category';
  static const String getCategoyrServices =
      '${ApiBaseConstant.baseUrlAPI}get_products';
  static const String checkPurchase =
      '${ApiBaseConstant.baseUrlAPI}is_already_purchase';
  static const String myNetwork =
      '${ApiBaseConstant.baseUrl}My_Network/my_network';
  static const String searchProduct =
      '${ApiBaseConstant.baseUrlAPI}product_search';
  static const String getSettings = '${ApiBaseConstant.baseUrlAPI}setting';
  static const String downloadInvoice =
      '${ApiBaseConstant.baseUrlAPI}invoice_pdf';
}
