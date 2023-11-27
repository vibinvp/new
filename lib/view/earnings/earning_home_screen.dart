// import 'package:flutter/material.dart';
// import 'package:paystome/helper/core/app_spacing.dart';
// import 'package:paystome/helper/core/color_constant.dart';
// import 'dart:ui';

// class WalletScreen extends StatefulWidget {
//   @override
//   _WalletScreenState createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
//   String selectedTransactionType = 'Expense';
//   List<String> transactionHistory = [
//     'Expense: \$50',
//     'Income: \$100',
//     'Expense: \$30',
//     'Transfer: \$20'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColoring.kAppWhiteColor,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: AppColoring.kAppWhiteColor),
//         backgroundColor: AppColoring.kAppColor,
//         title: const Text(
//           'Wallet',
//           style: TextStyle(fontSize: 20, color: AppColoring.kAppWhiteColor),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ListView(
//           children: <Widget>[
//             cardWidget(),
//             AppSpacing.ksizedBox50,
//             SizedBox(
//               height: 150,
//               child: Row(
//                 // shrinkWrap: true,
//                 // scrollDirection: Axis.horizontal,
//                 children: [
//                   typeCardWidget(context),
//                   AppSpacing.ksizedBoxW15,
//                   // typeCardWidget(context),
//                   AppSpacing.ksizedBoxW15,
//                   //   typeCardWidget(context),
//                 ],
//               ),
//             ),
//             AppSpacing.ksizedBox15,
//             const Text(
//               'Transaction Type:',
//               style: TextStyle(fontSize: 20),
//             ),
//             // DropdownButton<String>(
//             //   value: selectedTransactionType,
//             //   onChanged: (String? newValue) {
//             //     setState(() {
//             //       selectedTransactionType = newValue!;
//             //     });
//             //   },
//             //   items: <String>['Expense', 'Income', 'Transfer']
//             //       .map<DropdownMenuItem<String>>((String value) {
//             //     return DropdownMenuItem<String>(
//             //       value: value,
//             //       child: Text(value),
//             //     );
//             //   }).toList(),
//             // ),
//             const SizedBox(height: 20),
//             const Text(
//               'Transaction History:',
//               style: TextStyle(fontSize: 20),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 // physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: transactionHistory.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     title: Text(transactionHistory[index]),
//                   );
//                 },
//               ),
//             ),
//             //   typeCardWidget(context)
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget cardWidget() {
//   return Column(
    
//     children: [
//       // AppSpacing.ksizedBox50,
//       Stack(
//         children: [
//           Transform.rotate(
//             angle: -0.5,
//             child: const FittedBox(
//               child: Row(
//                 children: [
//                   Positioned(
//                     right: 5,
//                     top: 2,
//                     child: CircleAvatar(
//                       radius: 90,
//                       backgroundColor: AppColoring.yellow,
//                     ),
//                   ),
//                   AppSpacing.ksizedBox15,
//                   AppSpacing.ksizedBoxW15,
//                   Positioned(
//                     left: 5,
//                     bottom: 2,
//                     child: CircleAvatar(
//                       backgroundColor: AppColoring.successPopup,
//                       radius: 150,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           BankCard(),
//         ],
//       ),
//     ],
//   );
// }

// Widget typeCardWidget(context) {
//   return Container(
//     height: 90,
//     width: 200,
//     decoration: BoxDecoration(
//         color: AppColoring.kAppWhiteColor.withOpacity(0.5),
//         boxShadow: AppColoring.neumorpShadow,
//         borderRadius: BorderRadius.circular(20)),
//     child: const Padding(
//       padding: EdgeInsets.symmetric( vertical: 10.0,horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Balance',
//             style: TextStyle(fontSize: 12, color: AppColoring.blackLight),
//           ),
//           AppSpacing.ksizedBox10,
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: AppColoring.yellow,
//                 radius: 15,
//                 child: Text(
//                   '\$',
//                   style: TextStyle(
//                       fontSize: 18, color: AppColoring.black),
//                 ),
//               ),
//               AppSpacing.ksizedBoxW10,
//               Text(
//                 '1000',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: AppColoring.kAppWhiteColor),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// class BankCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     double fontSize(double size) {
//       return size * width / 414;
//     }

//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
//       child: Container(
//         height: 180,
//         decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.7),
//             boxShadow: AppColoring.neumorpShadow,
//             borderRadius: BorderRadius.circular(20)),
//         padding: EdgeInsets.symmetric(horizontal: width / 20, vertical: 5),
//         child: Stack(
//           children: <Widget>[
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                   alignment: Alignment.topLeft,
//                   width: width / 3.9,
//                   child: Image.asset(
//                     "assets/images/mastercardlogo.png",
//                     fit: BoxFit.fill,
//                   )),
//             ),
//             Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Container(
//                   height: height / 10,
//                   width: width / 1.9,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "**** **** **** ",
//                             style: TextStyle(
//                                 fontSize: fontSize(20),
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           Text(
//                             "1930",
//                             style: TextStyle(
//                                 fontSize: fontSize(30),
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       Text(
//                         "Platinum Card".toUpperCase(),
//                         style: TextStyle(
//                             fontSize: fontSize(15),
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 )),
//             // Align(
//             //   alignment: Alignment.bottomRight,
//             //   child: Container(
//             //     alignment: Alignment.bottomRight,
//             //     width: width / 6,
//             //     height: height / 16,
//             //     decoration: BoxDecoration(
//             //         color: AppColoring.primaryWhite,
//             //         boxShadow: AppColoring.neumorpShadow,
//             //         borderRadius: BorderRadius.circular(20)),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
