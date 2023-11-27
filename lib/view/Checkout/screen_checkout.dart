// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Cart/cart_controller.dart';
import 'package:paystome/controller/checkout/checkout_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Cart/get_cart_model.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Checkout/order_success.dart';
import 'package:paystome/view/Checkout/paymentscreen.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/pop_up_widget.dart';
import 'package:paystome/widget/row_two_item.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenCheckOut extends StatefulWidget {
  const ScreenCheckOut({super.key});

  @override
  State<ScreenCheckOut> createState() => _ScreenCheckOutState();
}

late CartController cartController;
late CheckoutController checkoutController;

class _ScreenCheckOutState extends State<ScreenCheckOut> {
  @override
  void initState() {
    cartController = Provider.of<CartController>(context, listen: false);
    checkoutController =
        Provider.of<CheckoutController>(context, listen: false);
    razorPayInitFn();
    checkoutController.isLoadPlaceOrder = false;
    checkoutController.initPhonepe();
    checkoutController.getInstalledUpiAppsForAndroid();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartController.getCartItems(context);
    });
    super.initState();
  }

  final Razorpay razorpay = Razorpay();

  void razorPayInitFn() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    context
        .read<CheckoutController>()
        .placeOrder(context: context, payType: 'cash');
    showToast(msg: 'Payment Success', clr: Colors.green);
    if (kDebugMode) {
      print("razresponse order id---->${response.orderId}");
      print("razresponse signature---->${response.signature}");
      print("razresponse paymentId---->${response.paymentId}");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showToast(msg: 'Payment Faild', clr: Colors.red);
    RouteConstat.back(context);
    log('Payment Faild');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('Payment ExternalWallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: checkoutButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cartItemListWidget(),
              AppSpacing.ksizedBox80,
              // priceDetails(),
              AppSpacing.ksizedBox150,
            ],
          ),
        ),
      ),
    );
  }

  Widget cartItemListWidget() {
    return Consumer(
      builder: (context, CartController cartController, child) {
        return cartController.isLoadingGetCart
            ? const ShimmerEffect()
            : cartController.cartItemList.isEmpty
                ? const SizedBox(
                    height: 600,
                    child: Center(
                      child: Text('No Data Found'),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Videos',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColoring.black,
                            fontWeight: FontWeight.w900),
                      ),
                      AppSpacing.ksizedBox10,
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartController.cartItemList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return listWiewItenWidget(
                              cartItem: cartController.cartItemList[index]);
                        },
                        separatorBuilder: (context, index) =>
                            AppSpacing.ksizedBox10,
                      ),
                    ],
                  );
      },
    );
  }

  Widget listWiewItenWidget({required CartItem cartItem}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: AppColoring.kAppColor,
            blurRadius: 1.0,
          ),
        ],
        color: AppColoring.lightBg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white,
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: cartItem.productFeaturedImage == null
                      ? Image.asset(
                          Utils.setPngPath("logo"),
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return const SingleBallnerItemSimmer();
                          },
                          fit: BoxFit.fill,
                          imageUrl: ApiBaseConstant.baseUrl +
                              AppConstant.categoryImageUrl +
                              cartItem.productFeaturedImage.toString()),
                ),
              ),
            ),
            AppSpacing.ksizedBoxW5,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    cartItem.productName ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    cartItem.productShortDescription ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '₹${cartItem.productPrice}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColoring.successPopup,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkoutButton(BuildContext context) {
    return Consumer(builder: (context, CartController value, child) {
      return value.isLoadingGetCart
          ? const Row()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColoring.lightBg,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    priceDetails(),
                    AppSpacing.ksizedBox15,
                    InkWell(
                      onTap: () async {
                        print('aaaaaaaaaaaaaaaaaaaaaaaa');
                        cartController.cartItemList.isNotEmpty
                            ? confirmOrderPopUp(context)
                            : showToast(
                                msg: 'Cart Is Empty',
                                clr: AppColoring.errorPopUp);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //  borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(15),
                          // topRight: Radius.circular(15)),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColoring.kAppColor,
                                AppColoring.kAppColor
                              ],
                              stops: [
                                0,
                                1
                              ]),
                        ),
                        child: Center(
                          child: Text(
                            'PLACE ORDER',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColoring.kAppWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: 'ubuntu',
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }

  Widget priceDetails() {
    return Consumer(builder: (context, CartController value, child) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColoring.kAppColor.withOpacity(.5),
              blurRadius: 2,
            ),
          ],
          color: AppColoring.kAppWhiteColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            RowTwoItemWidget(
                fontSize1: 13,
                fontWeight1: FontWeight.w600,
                text1: 'Price',
                text2: '₹${value.getCartModel?.total}'),
            const Divider(
              thickness: 1,
            ),
            RowTwoItemWidget(
                fontSize1: 13,
                text1: 'Total Items',
                fontWeight1: FontWeight.w600,
                text2: value.cartItemList.length.toString()),
            const Divider(
              thickness: 1,
            ),
            RowTwoItemWidget(
                fontSize1: 16,
                fontSize2: 16,
                fontWeight1: FontWeight.w600,
                fontWeight2: FontWeight.bold,
                text1: 'Total Price',
                text2: '₹${value.getCartModel?.total}')
          ],
        ),
      );
    });
  }

  confirmOrderPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Consumer2(
        builder:
            (context, CheckoutController value, CartController cart, child) {
          return value.isLoadPlaceOrder
              ? const LoadreWidget()
              : ConfirmationDialog(
                  icon: Utils.setPngPath('warning').toString(),
                  title: 'Are you sure to confirm?',
                  description: 'You want to confirm this order?',
                  onYesPressed: () async {
                    // showToast(
                    //     msg: 'Puchase is not available now',
                    //     clr: AppColoring.errorPopUp);
                    // RouteConstat.nextNamed(
                    //     context, const ScreenPhonepeScreen());
                    //RouteConstat.back(context);
                    // value.goToPayment(
                    //     double.parse(cart.getCartModel?.total ?? '0'), context);
                    // await goToPayment(cart.getCartModel?.total ?? '0',
                    //     'rzp_test_ESMA74o6WK0eru');
                  });

          // value.placeOrder(context: context, payType: 'cash');
        },
      ),
    );
  }

  Future<void> goToPayment(String amount, String razorpayKey) async {
    try {
      final email = await LocalStorage.getUserEmailFromSF();
      final number = await LocalStorage.getUserMobileFromSF();
      final options = {
        'key': razorpayKey.toString(),
        'amount': "${(num.parse(amount) * 100)}",
        'name': 'Paystome',
        'description': 'Paystome',
        'timeout': "300",
        'prefill': {
          'contact': number.toString(),
          'email': email.toString(),
        }
      };

      razorPayService(razorpay, options);
    } catch (e) {
      if (kDebugMode) {
        print("error razorpa ------?>>  $e");
      }
    }
  }

  void razorPayService(Razorpay razorpay, Map<String, Object> options) {
    try {
      print('called------------------------------------------>>.');
      razorpay.open(options);
    } catch (e) {
      print("error razorpa ------?>>  $e");
    }
  }
}
