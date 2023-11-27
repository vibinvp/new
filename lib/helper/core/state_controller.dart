import 'package:paystome/controller/Authentication/forgot_passweord_controler.dart';
import 'package:paystome/controller/Authentication/login_controller.dart';
import 'package:paystome/controller/Authentication/sign_up_controller.dart';
import 'package:paystome/controller/Authentication/snd_otp_controller.dart';
import 'package:paystome/controller/Cart/cart_controller.dart';
import 'package:paystome/controller/Dasboard/dashboard_controller.dart';
import 'package:paystome/controller/Payment/phonepe/phonepey_payment.dart';
import 'package:paystome/controller/Refferal/refferal_controller.dart';
import 'package:paystome/controller/Services/services_controller.dart';
import 'package:paystome/controller/Settings/settind_controller.dart';
import 'package:paystome/controller/Wallet/addmoney_controller.dart';
import 'package:paystome/controller/Wallet/wallet_controller.dart';
import 'package:paystome/controller/category/category_controller.dart';
import 'package:paystome/controller/checkout/checkout_controller.dart';
import 'package:paystome/controller/home/home_controller.dart';
import 'package:paystome/controller/orders/order_controller.dart';
import 'package:paystome/controller/profile/profile_controller.dart';
import 'package:paystome/controller/videoPlayer/youtube_video_player.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../controller/videoPlayer/video_player_controller.dart';

class ProviderStateController {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => DashboardController(),
    ),
    ChangeNotifierProvider(
      create: (context) => SendOTPController(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignUpController(),
    ),
    ChangeNotifierProvider(
      create: (context) => ForgotPasswordController(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingController(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileController(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeController(),
    ),
    ChangeNotifierProvider(
      create: (context) => ServiceController(),
    ),
    ChangeNotifierProvider(
      create: (context) => VideoPlayController(),
    ),
    ChangeNotifierProvider(
      create: (context) => CategoryController(),
    ),
    ChangeNotifierProvider(
      create: (context) => VideoPlayController(),
    ),
    ChangeNotifierProvider(
      create: (context) => WalletController(),
    ),
    ChangeNotifierProvider(
      create: (context) => PlanController(),
    ),
    ChangeNotifierProvider(
      create: (context) => YouTubeVideoPlayController(),
    ),
    ChangeNotifierProvider(
      create: (context) => CartController(),
    ),
    ChangeNotifierProvider(
      create: (context) => CheckoutController(),
    ),
    ChangeNotifierProvider(
      create: (context) => OrderController(),
    ),
    ChangeNotifierProvider(
      create: (context) => RefferalController(),
    ),
    ChangeNotifierProvider(
      create: (context) => PhonepePaymentController(),
    ),
  ];
}
