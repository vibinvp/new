import 'package:flutter/material.dart';
import 'package:paystome/controller/Wallet/wallet_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/model/wallet/transaction_model.dart';
import 'package:paystome/widget/row_two_item.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColoring.kAppColor,
        leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          'History',
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            AppSpacing.ksizedBox20,
            // const Text(
            //   'Transaction History',
            //   style: TextStyle(
            //       color: AppColoring.black, fontWeight: FontWeight.bold),
            // ),
            // AppSpacing.ksizedBox15,
            categoryRoadsideServiceWidget()
          ],
        ),
      )),
    );
  }

  Widget categoryRoadsideServiceWidget() {
    return Consumer(
      builder: (context, WalletController value, child) {
        return value.isLoadgetWalletTransactions ||
                value.walletTransactionModel == null
            ? const ShimmerEffect()
            : value.transactionList.isEmpty
                ? const SizedBox(
                    height: 600,
                    child: Center(
                      child: Text('No Transactions Found!'),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: value.transactionList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return gridViewIten(
                          context, value.transactionList[index]);
                    },
                    separatorBuilder: (context, index) =>
                        AppSpacing.ksizedBox10,
                  );
      },
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
          //  border: Border.all(color: AppColoring.blackLight, width: .5)
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
              fontSize2: 14,
              fontWeight2: FontWeight.bold,
              color2: AppColoring.blackLight,
            ),
            AppSpacing.ksizedBox10,
          ],
        ),
      ),
    );
  }
}
