import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:intl/intl.dart';
import 'package:paystome/controller/Refferal/refferal_controller.dart';
import 'package:paystome/controller/Wallet/wallet_controller.dart';
import 'package:paystome/controller/profile/profile_controller.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Refferal/network_model.dart';
import 'package:paystome/model/wallet/transaction_model.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Refferal/refferal_trees.dart';
import 'package:paystome/view/earnings/transaction_history.dart';
import 'package:paystome/view/earnings/withdraw_request_history.dart';
import 'package:paystome/widget/pop_up_widget.dart';
// import 'package:paystome/model/Wallet/transaction_model.dart';
// import 'package:paystome/view/Wallet/plan_details.dart';
import 'package:paystome/widget/row_two_item.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class MyEarningsScreen extends StatefulWidget {
  const MyEarningsScreen({super.key});

  @override
  State<MyEarningsScreen> createState() => _MyEarningsScreenState();
}

class _MyEarningsScreenState extends State<MyEarningsScreen>
    with SingleTickerProviderStateMixin {
  late ProfileController profileController;
  late WalletController walletController;
  late RefferalController refferalController;
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  String userId = '1020';

  void getName() async {
    var code = await LocalStorage.getUserUserIdSF();
    setState(() {
      userId = code ?? '';
      userId = userId.length <= 1
          ? '000$userId'
          : userId.length <= 2
              ? '00$userId'
              : userId.length <= 3
                  ? '0$userId'
                  : userId;
    });
  }

  @override
  void initState() {
    profileController = Provider.of<ProfileController>(context, listen: false);
    walletController = Provider.of<WalletController>(context, listen: false);
    refferalController =
        Provider.of<RefferalController>(context, listen: false);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getName();
      //   profileController.getUserDetails(context);
      walletController.getWalletTransactions(context, '0');
      walletController.getWallet();
      refferalController.getReferalList(context);
    });
    super.initState();
  }

  Future<void> refresh() async {
    walletController.getWalletTransactions(context, '0');
    walletController.getWallet();
    refferalController.getReferalList(context);
  }

  Widget showLoadingDialog(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColoring.kAppWhiteColor.withOpacity(.2),
      ),
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppColoring.primaryWhite.withOpacity(.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
              child: CircularProgressIndicator(
            color: AppColoring.blackLight,
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await refresh();
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Consumer(
          builder: (context, WalletController value, child) {
            return value.sendRequest
                ? showLoadingDialog(context)
                : const SizedBox();
          },
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015)
                    ..rotateY(pi * _animation.value),
                  child: _animation.value <= 0.5 ? cardWidget() : cardWidget()),
              // AppSpacing.ksizedBox50,

              AppSpacing.ksizedBox15,
              fetursecardWidget(),
              AppSpacing.ksizedBox15,
              //walletCard(context),
              AppSpacing.ksizedBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transaction History',
                    style: TextStyle(
                        color: AppColoring.black, fontWeight: FontWeight.bold),
                  ),
                  Consumer(
                    builder: (context, WalletController value, child) {
                      return value.transactionList.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                RouteConstat.nextNamed(
                                    context, const TransactionHistory());
                              },
                              child: const Text(
                                'Show All',
                                style: TextStyle(
                                    color: AppColoring.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox();
                    },
                  )
                ],
              ),
              AppSpacing.ksizedBox15,
              transactionHistory()
            ],
          ),
        )),
      ),
    );
  }

  Widget fetursecardWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: typeCardWidget(context, 'Refferal Tree', 1)),
        AppSpacing.ksizedBoxW15,
        Expanded(child: typeCardWidget(context, 'Withdraw Request', 2)),
        AppSpacing.ksizedBoxW15,
        Expanded(child: typeCardWidget(context, 'Withdraw History', 3)),
      ],
    );
  }

  Widget transactionHistory() {
    return Expanded(
      child: Consumer(
        builder: (context, WalletController value, child) {
          return value.isLoadgetWalletTransactions ||
                  value.walletTransactionModel == null
              ? const ShimmerEffect()
              : value.transactionList.isEmpty
                  ? const Center(
                      child: Text('No Transactions Found!'),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.transactionList.length >= 4
                          ? 4
                          : value.transactionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return gridViewIten(
                            context, value.transactionList[index]);
                      },
                      separatorBuilder: (context, index) =>
                          AppSpacing.ksizedBox10,
                    );
        },
      ),
    );
  }

  Widget gridViewIten(context, TransactionData transactions) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          //     color: AppColoring.primaryWhite.withOpacity(0.2),
          boxShadow: AppColoring.containerShadow,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: AppColoring.blackLight, width: .5)
          // color: AppColoring.kAppBlueColor,
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 1,
          shadowColor: AppColoring.kAppColor.withOpacity(.5),
          color: AppColoring.kAppWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowTwoItemWidget(
                text1: 'Txn. Id:#${transactions.id}',
                text2: '🕐 ${transactions.createdAt}',
                //text2: transactions.vendorPoints ?? "0",
                fontSize1: 14,
                fontSize2: 14,
                color2: AppColoring.blackLight,
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: Text(
                  '${transactions.comment}',
                  //  'Message : ${transactions.message}',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: AppColoring.black,
                  ),
                ),
              ),
              RowTwoItemWidget(
                text1: '${transactions.type}',
                text2: '₹${transactions.amount}',
                //text2: transactions.vendorPoints ?? "0",
                fontSize1: 14,
                fontSize2: 18,
                fontWeight2: FontWeight.bold,
                color2: AppColoring.blackLight,
              ),
              AppSpacing.ksizedBox10,
            ],
          ),
        ),
      ),
    );
  }

  Widget cardWidget() {
    return
        // Stack(
        //   children: [
        // Transform.rotate(
        //   angle: -0.5,
        //   child: const FittedBox(
        //     child: Row(
        //       children: [
        //         Positioned(
        //           right: 5,
        //           top: 2,
        //           child: CircleAvatar(
        //             radius: 90,
        //             backgroundColor: AppColoring.yellow,
        //           ),
        //         ),
        //         AppSpacing.ksizedBoxW15,
        //         Positioned(
        //           left: 5,
        //           bottom: 2,
        //           child: CircleAvatar(
        //             backgroundColor: AppColoring.successPopup,
        //             radius: 150,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        InkWell(
            onTap: () {
              if (_status == AnimationStatus.dismissed) {
                _controller.forward();

                Future.delayed(const Duration(seconds: 1)).then((value) {
                  _controller.reverse();
                });
              } else {}
            },
            child: bankCard(context));
  }

  Widget typeCardWidget(context, String heading, int index) {
    return Card(
      elevation: 10,
      color: index == 1
          ? const Color.fromARGB(255, 141, 122, 27).withOpacity(0.5)
          : index == 2
              ? const Color.fromARGB(255, 194, 71, 50).withOpacity(0.5)
              : const Color.fromARGB(255, 35, 133, 117).withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer2(builder:
          (context, RefferalController value, WalletController wallet, child) {
        return InkWell(
          onTap: () {
            if (index == 1) {
              if (value.referredUsersTree.isNotEmpty) {
                RouteConstat.nextNamed(
                  context,
                  ReferredUsersTreeScreen(
                      referredUsersTree:
                          value.referredUsersTree // Your response data here
                      ),
                );
              } else {
                showToast(
                    msg: 'No Refferal List Available',
                    clr: AppColoring.errorPopUp);
              }
            } else if (index == 2) {
              if (wallet.walletModel!.data!.referTotal!.totalProductSale!.unpaid
                      .toString()
                      .toString()
                      .replaceAll('Rs', '')
                      .isNotEmpty &&
                  wallet.walletModel!.data!.referTotal!.totalProductSale!.unpaid
                          .toString()
                          .toString()
                          .replaceAll('Rs', '') !=
                      '' &&
                  wallet.walletModel!.data!.referTotal!.totalProductSale!.unpaid
                          .toString()
                          .toString()
                          .replaceAll('Rs', '') !=
                      '0') {
                confirmWithdrawRequest(context, onYesPressed: () {
                  RouteConstat.back(context);
                  wallet.sendWithdrawRequest();
                });
              } else {
                showToast(
                    msg: 'Insufficient Balance', clr: AppColoring.errorPopUp);
              }
            } else {
              RouteConstat.nextNamed(
                context,
                const WithdrowRequestHistoryScreen(),
              );
            }
          },
          child: Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
                color: index == 1
                    ? const Color(0xFFD9BE3B).withOpacity(0.5)
                    : index == 2
                        ? const Color(0xFFE88F7F).withOpacity(0.5)
                        : const Color(0xFF6FC6B8).withOpacity(0.5),
                boxShadow: AppColoring.neumorpShadow,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColoring.kAppWhiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  confirmWithdrawRequest(BuildContext context,
      {required final Function onYesPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationDialog(
          icon: Utils.setPngPath('warning').toString(),
          title: 'Do you Updated Your Bank Details?',
          description: 'If it is done click yes to request',
          onYesPressed: onYesPressed),
    );
  }

  Widget bankCard(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double fontSize(double size) {
      return size * width / 414;
    }

    return Material(
      elevation: 10,
      shadowColor: AppColoring.kAppWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
              //  color: AppColoring.kAppColor.withOpacity(0.9),
              color: const Color(0xFF3A81C3).withOpacity(0.5).withOpacity(0.85),
              boxShadow: AppColoring.neumorpShadow,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: width / 20, vertical: 15),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    alignment: Alignment.topLeft,
                    width: width / 3.9,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                    )),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    height: height / 10,
                    width: width / 1.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "**** **** ****  ",
                              style: TextStyle(
                                  color: AppColoring.kAppWhiteColor,
                                  fontSize: fontSize(20),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              userId,
                              style: TextStyle(
                                  color: AppColoring.kAppWhiteColor,
                                  fontSize: fontSize(20),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Text(
                          AppConstant.appName.toUpperCase(),
                          style: TextStyle(
                              fontSize: fontSize(15),
                              color: AppColoring.kAppWhiteColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
              Positioned(
                  right: 10,
                  top: 10,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColoring.primaryApp,
                        radius: 15,
                        child: const Text(
                          '₹',
                          style: TextStyle(
                              fontSize: 18, color: AppColoring.kAppWhiteColor),
                        ),
                      ),
                      AppSpacing.ksizedBoxW10,
                      Consumer(
                        builder: (context, WalletController value, child) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            //value.getWallet();
                          });
                          return value.isLoadgetWallet ||
                                  value.walletModel == null
                              ? const SingleBallnerItemSimmer()
                              : Text(
                                  value.walletModel!.data == null
                                      ? '00'
                                      : value.walletModel!.data!.referTotal ==
                                              null
                                          ? '00'
                                          : value.walletModel!.data!.referTotal!
                                              .totalProductSale!.unpaid==null? '00'
                                          : value.walletModel!.data!.referTotal!
                                              .totalProductSale!.unpaid
                                              .toString()
                                              .replaceAll('Rs', ''),
                                  style: const TextStyle(
                                    color: AppColoring.kAppWhiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                        },
                      ),
                    ],
                    // ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
