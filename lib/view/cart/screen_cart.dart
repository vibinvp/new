import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paystome/controller/Cart/cart_controller.dart';
import 'package:paystome/helper/api/base_constatnt.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/model/Cart/get_cart_model.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Checkout/screen_checkout.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/pop_up_widget.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

late CartController cartController;

class _ScreenCartState extends State<ScreenCart> {
  @override
  void initState() {
    cartController = Provider.of<CartController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartController.getCartItems(context);
    });
    super.initState();
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
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              cartItemListWidget(),
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
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartController.cartItemList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return listWiewItenWidget(
                          cartItem: cartController.cartItemList[index]);
                    },
                    separatorBuilder: (context, index) =>
                        AppSpacing.ksizedBox10,
                  );
      },
    );
  }

  Widget listWiewItenWidget({required CartItem cartItem}) {
    return Stack(
      children: [
        Container(
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
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: <Widget>[
                // InkWell(
                //   onTap: () {
                //     delteCartItem(context, cartId: cartItem.cartId);
                //   },
                //   child: const Icon(
                //     Icons.delete_outlined,
                //     color: AppColoring.errorPopUp,
                //   ),
                // ),
                //         AppSpacing.ksizedBox50,
                //         const Text(
                //           '',
                //           style: TextStyle(
                //               fontSize: 14,
                //               color: AppColoring.successPopup,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                delteCartItem(context, cartId: cartItem.cartId);
              },
              child: const Icon(
                Icons.delete_outlined,
                color: AppColoring.errorPopUp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget checkoutButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //     color: Theme.of(context).colorScheme.white,
        boxShadow: [
          BoxShadow(
            color: AppColoring.kAppWhiteColor,
            blurRadius: 10,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {},
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    height: 50,
                    child: Center(child: Consumer(
                      builder: (context, CartController value, child) {
                        return value.totalAmount != ''
                            ? Text(
                                'TOTAL:₹${value.totalAmount}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColoring.kAppColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      //fontFamily: 'ubuntu',
                                    ),
                              )
                            : const Text('');
                      },
                    )),
                  ),
                ),
              ),
            ),
            AppSpacing.ksizedBoxW20,
            Expanded(
              child: InkWell(
                onTap: () async {
                  cartController.cartItemList.isNotEmpty
                      ? RouteConstat.nextNamed(context, const ScreenCheckOut())
                      // ? confirmOrderPopUp(context)
                      : showToast(
                          msg: 'Cart Is Empty', clr: AppColoring.errorPopUp);
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor: AppColoring.kAppColor,
                  ),
                  onPressed: () {
                    cartController.cartItemList.isNotEmpty
                        ? RouteConstat.nextNamed(
                            context, const ScreenCheckOut())
                        // ? confirmOrderPopUp(context)
                        : showToast(
                            msg: 'Cart Is Empty', clr: AppColoring.errorPopUp);
                  },
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
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
                        'CHECK OUT',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColoring.kAppWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: 'ubuntu',
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  confirmOrderPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          Consumer(builder: (context, CartController value, child) {
        return ConfirmationDialog(
          icon: Utils.setPngPath('warning').toString(),
          title: 'Are you sure to confirm?',
          description: 'You want to confirm this order?',
          onYesPressed: () {},
        );
      }),
    );
  }

  delteCartItem(BuildContext context, {required cartId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          Consumer(builder: (context, CartController value, child) {
        return value.isLoadingdeleteCart
            ? const LoadreWidget()
            : ConfirmationDialog(
                icon: Utils.setPngPath('warning').toString(),
                title: 'Are you sure to confirm?',
                description: 'You want to delete this item?',
                onYesPressed: () {
                  value.deleteCartItem(context, cartId: cartId).then((value) {
                    RouteConstat.back(context);
                  });
                },
              );
      }),
    );
  }
}
