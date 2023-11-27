import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paystome/controller/checkout/checkout_controller.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';

class ScreenPhonepeScreen extends StatefulWidget {
  const ScreenPhonepeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenPhonepeScreen> createState() => _GetDesignState();
}

class _GetDesignState extends State<ScreenPhonepeScreen> {
  double? price;

  int id = 0;

  final saltKey = "4a181d5f-624e-45a5-bee4-57d634ce4828";
  //final saltKey = 'fac2b7e3-7c26-4d4e-b373-c3e9a9959734'; //test key
  final saltIndex = 1;
  final apiEndpoint = "/pg/v1/pay";
  final merchantId = 'ADVITHAONLINE';
  // final merchantId = 'PGTESTPAYUAT142';

  Object? result;

  @override
  void initState() {
    super.initState();

    initMethed(
        'PRODUCTION', '57dc384d2dd8497d822a571d650a0bf2', merchantId, true);
    getPackageSignatureForAndroid();
  }

  getPackageSignatureForAndroid() {
    if (Platform.isAndroid) {
      PhonePePaymentSdk.getPackageSignatureForAndroid()
          .then((packageSignature) => {
                setState(() {
                  result = 'getPackageSignatureForAndroid - $packageSignature';
                  print('initMethed 111111 ----   >>  $result');
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    }
  }

  initMethed(String environment, String appId, String merchantId,
      bool enableLogging) async {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
                print('initMethed ----   >>  $result');
              })
            })
        .catchError((error) {
      // handleError(error);
      return <dynamic>{};
    });
  }

  Future<Map<dynamic, dynamic>?> startPGTransaction(
      String body,
      String callback,
      String checksum,
      Map<String, String> headers,
      String apiEndPoint,
      String? packageName,
      amount,
      String merchantTransactionId) async {
    PhonePePaymentSdk.startPGTransaction(
            body, callback, checksum, headers, apiEndPoint, packageName)
        .then((response) => {
              setState(
                () {
                  print(response.toString());
                  if (response != null) {
                    String status = response['status'].toString();
                    String error = response['error'].toString();
                    if (status == 'SUCCESS') {
                      result = "Flow Completed - Status: Success!";

                      handlePaymentSuccess(amount, merchantTransactionId);
                    } else {
                      //  Get.to(() => const PaymentFailure());
                      result =
                          "Flow Completed - Status: $status and Error: $error";
                    }
                  } else {
                    result = "Flow Incomplete";
                  }
                },
              ),
              print('result ---->>  $result'),
            })
        .catchError(
      (error) {
        handleError(error);
        //  Get.to(() => const PaymentFailure());
        return <dynamic>{};
      },
    );
    return null;
  }

  void handleError(error) {
    setState(() {
      if (error is Exception) {
        result = error.toString();
      } else {
        result = {"error": error};
      }
    });
  }

  void handlePaymentSuccess(amount, merchantTransactionId) async {
    // await Get.to(() => const PaymentSuccess());
    // productUidList.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppBar(),
        ),
        body: SafeArea(
          child: Consumer(
            builder: (context, CheckoutController value, child) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    //print(value.upiApps[index].applicationName ?? '');
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: AppColoring.kAppColor.withOpacity(0.3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        value.upiApps[index].applicationName ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColoring.kAppColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: value.upiApps.length);
            },
          ),
        ),
        floatingActionButton: GestureDetector(
            onTap: () async {
              // var price = 100.0;

              // if (price == 0) {
              //   Fluttertoast.showToast(msg: 'Please select drawings');
              // } else {
              //   const double price = 10.0;

              //   const double phonePePrice = price * 100;

              //   String merchantTransactionId =
              //       'DMH${DateTime.now().millisecondsSinceEpoch}';

              //   final jsonData = {
              //     "merchantId": merchantId,
              //     "merchantTransactionId": merchantTransactionId,
              //     "merchantUserId": "MUID123",
              //     "amount": phonePePrice,
              //     "redirectUrl": "",
              //     "redirectMode": "POST",
              //     "callbackUrl": "",
              //     "mobileNumber": "9999999998",
              //     "paymentInstrument": {"type": "PAY_PAGE"},
              //     "deviceContext": {
              //       "deviceOS": Platform.isIOS ? "IOS" : "ANDROID"
              //     }
              //   };

              //   String jsonString = jsonEncode(jsonData);
              //   String base64Data = jsonString.toBase64;
              //   String dataToHash = base64Data + apiEndpoint + saltKey;
              //   String sHA256 = generateSha256Hash(dataToHash);

              //   print('$jsonData');

              //   String checksum = '$sHA256###$saltIndex';

              //   startPGTransaction(
              //       base64Data,
              //       'https://webhook.site/callback-url',
              //       checksum,
              //       {"Content-Type": "application/json"},
              //       "/pg/v1/pay",
              //       'com.paystome',
              //       price,
              //       merchantTransactionId);
              // }
            },
            child: GestureDetector(
              onTap: () {
                var price = 100.0;

                if (price == 0) {
                  Fluttertoast.showToast(msg: 'Please select drawings');
                } else {
                  const double price = 10.0;

                  const double phonePePrice = price * 100;

                  String merchantTransactionId =
                      'DMH${DateTime.now().millisecondsSinceEpoch}';

                  final jsonData = {
                    "merchantId": merchantId,
                    "merchantTransactionId": merchantTransactionId,
                    "merchantUserId": "MUID123",
                    "amount": phonePePrice,
                    "redirectUrl": "",
                    "redirectMode": "POST",
                    "callbackUrl": "",
                    "mobileNumber": "9999999998",
                    "paymentInstrument": {"type": "PAY_PAGE"},
                    "deviceContext": {
                      "deviceOS": Platform.isIOS ? "IOS" : "ANDROID"
                    }
                  };

                  String jsonString = jsonEncode(jsonData);
                  String base64Data = jsonString;
                  String dataToHash = base64Data + apiEndpoint + saltKey;
                  String sHA256 = generateSha256Hash(dataToHash);

                  print('$jsonData');

                  String checksum = '$sHA256###$saltIndex';

                  startPGTransaction(
                      base64Data,
                      'https://webhook.site/callback-url',
                      checksum,
                      {"Content-Type": "application/json"},
                      "/pg/v1/pay",
                      'com.paystome',
                      price,
                      merchantTransactionId);
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  width: (MediaQuery.of(context).size.width) / 1.1,
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColoring.kAppColor),
                  child: const Text('Buy',
                      style: TextStyle(
                          fontSize: 15, color: AppColoring.kAppWhiteColor))),
            )));
  }

  String generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}

extension EncodingExtensions on String {
  /// To Base64
  /// This is used to convert the string to base64
  String get toBase64 {
    return base64.encode(toUtf8);
  }

  /// To Utf8
  /// This is used to convert the string to utf8
  List<int> get toUtf8 {
    return utf8.encode(this);
  }

  /// To Sha256
  /// This is used to convert the string to sha256
  String get toSha256 {
    return sha256.convert(toUtf8).toString();
  }
}



















// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:paystome/view/Checkout/upi_app.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

// class ScreenPhonepeScreen extends StatefulWidget {
//   const ScreenPhonepeScreen({super.key});

//   @override
//   State<ScreenPhonepeScreen> createState() => MerchantScreen();
// }

// class MerchantScreen extends State<ScreenPhonepeScreen> {
//   String body = "";
//   String callback = "flutterDemoApp";
//   String checksum = "";

//   Map<String, String> headers = {};
//   Map<String, String> pgHeaders = {"Content-Type": "application/json"};
//   List<String> apiList = <String>['Container', 'PG'];
//   List<String> environmentList = <String>['UAT', 'UAT_SIM', 'PRODUCTION'];
//   String apiEndPoint = "/pg/v1/pay";
//   bool enableLogs = true;
//   Object? result;
//   String dropdownValue = 'PG';
//   String environmentValue = 'UAT_SIM';
//   String appId = "0000000";
//   String merchantId = "PGTESTPAYUAT142";
//   String packageName = "com.phonepe.simulator";

//   void startTransaction() {
//     dropdownValue == 'Container'
//         ? startContainerTransaction()
//         : startPGTransaction();
//   }

//   void initPhonePeSdk() {
//     PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs)
//         .then((isInitialized) => {
//               setState(() {
//                 result = 'PhonePe SDK Initialized - $isInitialized';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void isPhonePeInstalled() {
//     PhonePePaymentSdk.isPhonePeInstalled()
//         .then((isPhonePeInstalled) => {
//               setState(() {
//                 result = 'PhonePe Installed - $isPhonePeInstalled';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void isGpayInstalled() {
//     PhonePePaymentSdk.isGPayAppInstalled()
//         .then((isGpayInstalled) => {
//               setState(() {
//                 result = 'GPay Installed - $isGpayInstalled';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void isPaytmInstalled() {
//     PhonePePaymentSdk.isPaytmAppInstalled()
//         .then((isPaytmInstalled) => {
//               setState(() {
//                 result = 'Paytm Installed - $isPaytmInstalled';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }

//   void getPackageSignatureForAndroid() {
//     if (Platform.isAndroid) {
//       PhonePePaymentSdk.getPackageSignatureForAndroid()
//           .then((packageSignature) => {
//                 setState(() {
//                   result = 'getPackageSignatureForAndroid - $packageSignature';
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     }
//   }

//   void getInstalledUpiAppsForAndroid() {
//     if (Platform.isAndroid) {
//       PhonePePaymentSdk.getInstalledUpiAppsForAndroid()
//           .then((apps) => {
//                 setState(() {
//                   if (apps != null) {
//                     Iterable l = json.decode(apps);
//                     List<UPIApp> upiApps = List<UPIApp>.from(
//                         l.map((model) => UPIApp.fromJson(model)));
//                     String appString = '';
//                     for (var element in upiApps) {
//                       appString +=
//                           "${element.applicationName} ${element.version} ${element.packageName}";
//                     }
//                     result = 'Installed Upi Apps - $appString';
//                   } else {
//                     result = 'Installed Upi Apps - 0';
//                   }
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     }
//   }

//   void startPGTransaction() async {
//     try {
//       PhonePePaymentSdk.startPGTransaction(
//               body, callback, checksum, pgHeaders, apiEndPoint, packageName)
//           .then((response) => {
//                 setState(() {
//                   if (response != null) {
//                     String status = response['status'].toString();
//                     String error = response['error'].toString();
//                     if (status == 'SUCCESS') {
//                       result = "Flow Completed - Status: Success!";
//                     } else {
//                       result =
//                           "Flow Completed - Status: $status and Error: $error";
//                     }
//                   } else {
//                     result = "Flow Incomplete";
//                   }
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     } catch (error) {
//       handleError(error);
//     }
//   }

//   void handleError(error) {
//     setState(() {
//       if (error is Exception) {
//         result = error.toString();
//       } else {
//         result = {"error": error};
//       }
//     });
//   }

//   void startContainerTransaction() async {
//     try {
//       PhonePePaymentSdk.startContainerTransaction(
//               body, callback, checksum, headers, apiEndPoint)
//           .then((response) => {
//                 setState(() {
//                   if (response != null) {
//                     String status = response['status'].toString();
//                     String error = response['error'].toString();
//                     if (status == 'SUCCESS') {
//                       result = "Flow Completed - Status: Success!";
//                     } else {
//                       result =
//                           "Flow Completed - Status: $status and Error: $error";
//                     }
//                   } else {
//                     result = "Flow Incomplete";
//                   }
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     } catch (error) {
//       result = {"error": error};
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Flutter Merchant Demo App'),
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//               margin: const EdgeInsets.all(7),
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Merchant Id',
//                     ),
//                     onChanged: (text) {
//                       merchantId = text;
//                     },
//                   ),
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'App Id',
//                     ),
//                     onChanged: (text) {
//                       appId = text;
//                     },
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       const Text('Select the environment'),
//                       DropdownButton<String>(
//                         value: environmentValue,
//                         icon: const Icon(Icons.arrow_downward),
//                         elevation: 16,
//                         underline: Container(
//                           height: 2,
//                           color: Colors.black,
//                         ),
//                         onChanged: (String? value) {
//                           setState(() {
//                             environmentValue = value!;
//                             if (environmentValue == 'PRODUCTION') {
//                               packageName = "com.phonepe.app";
//                             } else if (environmentValue == 'UAT') {
//                               packageName = "com.phonepe.app.preprod";
//                             } else if (environmentValue == 'UAT_SIM') {
//                               packageName = "com.phonepe.simulator";
//                             }
//                           });
//                         },
//                         items: environmentList
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       )
//                     ],
//                   ),
//                   Visibility(
//                       maintainSize: false,
//                       maintainAnimation: false,
//                       maintainState: false,
//                       visible: Platform.isAndroid,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             const SizedBox(height: 10),
//                             Text("Package Name: $packageName"),
//                           ])),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: <Widget>[
//                       Checkbox(
//                           value: enableLogs,
//                           onChanged: (state) {
//                             setState(() {
//                               enableLogs = state!;
//                             });
//                           }),
//                       const Text("Enable Logs")
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Warning: Init SDK is Mandatory to use all the functionalities*',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   ElevatedButton(
//                       onPressed: initPhonePeSdk, child: const Text('INIT SDK')),
//                   const SizedBox(width: 5.0),
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'body',
//                     ),
//                     onChanged: (text) {
//                       body = text;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'checksum',
//                     ),
//                     onChanged: (text) {
//                       checksum = text;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       const Text('Select the transaction type'),
//                       DropdownButton<String>(
//                         value: dropdownValue,
//                         icon: const Icon(Icons.arrow_downward),
//                         elevation: 16,
//                         underline: Container(
//                           height: 2,
//                           color: Colors.black,
//                         ),
//                         onChanged: (String? value) {
//                           // This is called when the user selects an item.
//                           setState(() {
//                             dropdownValue = value!;
//                             if (dropdownValue == 'PG') {
//                               apiEndPoint = "/pg/v1/pay";
//                             } else {
//                               apiEndPoint = "/v4/debit";
//                             }
//                           });
//                         },
//                         items: apiList
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       )
//                     ],
//                   ),
//                   ElevatedButton(
//                       onPressed: startTransaction,
//                       child: const Text('Start Transaction')),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: isPhonePeInstalled,
//                                 child: const Text('PhonePe App'))),
//                         const SizedBox(width: 5.0),
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: isGpayInstalled,
//                                 child: const Text('Gpay App'))),
//                         const SizedBox(width: 5.0),
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: isPaytmInstalled,
//                                 child: const Text('Paytm App'))),
//                       ]),
//                   Visibility(
//                       maintainSize: false,
//                       maintainAnimation: false,
//                       maintainState: false,
//                       visible: Platform.isAndroid,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(
//                                 child: ElevatedButton(
//                                     onPressed: getPackageSignatureForAndroid,
//                                     child:
//                                         const Text('Get Package Signature'))),
//                             const SizedBox(width: 5.0),
//                             Expanded(
//                                 child: ElevatedButton(
//                                     onPressed: getInstalledUpiAppsForAndroid,
//                                     child: const Text('Get UPI Apps'))),
//                             const SizedBox(width: 5.0),
//                           ])),
//                   Text("Result: \n $result")
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
