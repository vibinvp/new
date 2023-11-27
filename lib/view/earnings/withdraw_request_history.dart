import 'package:flutter/material.dart';
import 'package:paystome/controller/Wallet/wallet_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/model/wallet/transaction_model.dart';
import 'package:paystome/model/wallet/withdraw_request_model.dart';
import 'package:paystome/widget/row_two_item.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class WithdrowRequestHistoryScreen extends StatefulWidget {
  const WithdrowRequestHistoryScreen({super.key});

  @override
  State<WithdrowRequestHistoryScreen> createState() =>
      _WithdrowRequestHistoryScreenState();
}

class _WithdrowRequestHistoryScreenState
    extends State<WithdrowRequestHistoryScreen> {
  late WalletController walletController;
  @override
  void initState() {
    walletController = Provider.of<WalletController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      walletController.getWithdrawRequest(context, '0');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          "Withdraw Request History",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColoring.kAppBlueColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          categoryRoadsideServiceWidget(),
        ],
      ),
    );
  }

  Widget categoryRoadsideServiceWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(
        builder: (context, WalletController value, child) {
          return value.isLoadgetwithdrawRequest ||
                  value.walletTransactionModel == null
              ? const ShimmerEffect()
              : value.withdrawRequestList.isEmpty
                  ? const SizedBox(
                      height: 600,
                      child: Center(
                        child: Text('No Transactions Found!'),
                      ),
                    )
                  : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.withdrawRequestList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return gridViewIten(
                            context, value.withdrawRequestList[index]);
                      },
                      separatorBuilder: (context, index) =>
                          AppSpacing.ksizedBox10,
                    );
        },
      ),
    );
  }

  Widget gridViewIten(context, RequestList transactions) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: AppColoring.primaryWhite.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
              color: transactions.status == '0'
                  ? AppColoring.yellow.withOpacity(.2)
                  : transactions.status == '1'
                      ? AppColoring.successPopup.withOpacity(.2)
                      : AppColoring.errorPopUp.withOpacity(.2),
              //   blurRadius: 5.0,
            )
          ],
          // boxShadow: AppColoring.containerShadow,
          borderRadius: BorderRadius.circular(8),
          //border: Border.all(color: AppColoring.blackLight, width: .5)
          // color: AppColoring.kAppBlueColor,
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
            Row(
              children: [
                Card(
                  color: transactions.status == '0'
                      ? AppColoring.yellow
                      : transactions.status == '1'
                          ? AppColoring.successPopup
                          : AppColoring.errorPopUp,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Text(
                      transactions.status == '0'
                          ? 'Request Send'
                          : transactions.status == '1'
                              ? 'PAID'
                              : 'Rejected',
                      //  'Message : ${transactions.message}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: transactions.status == '0'
                              ? AppColoring.black
                              : transactions.status == '1'
                                  ? AppColoring.kAppWhiteColor
                                  : AppColoring.kAppWhiteColor),
                    ),
                  ),
                ),
              ],
            ),
            RowTwoItemWidget(
              text1: '${transactions.preferMethod}',
              text2: '₹${transactions.total}',
              //text2: transactions.vendorPoints ?? "0",
              fontSize1: 14,
              fontSize2: 18,
              fontWeight2: FontWeight.bold,
              color2: AppColoring.blackLight,
            ),
            AppSpacing.ksizedBox3,
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            //   child: Text(
            //     '${transactions.status}',
            //     //  'Message : ${transactions.message}',
            //     style: const TextStyle(
            //       fontWeight: FontWeight.normal,
            //       fontSize: 14,
            //       color: AppColoring.black,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
