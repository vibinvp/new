import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:paystome/controller/Payment/phonepe/phonepey_payment.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:provider/provider.dart';

class PhonepePaymentScreen extends StatefulWidget {
  const PhonepePaymentScreen({
    Key? key,
    required this.paymentUrl,
    required this.merchantTransactionId,
    required this.amount,
    required this.paymentType,
    required this.itemName,
  }) : super(key: key);
  final String paymentUrl;
  final String amount;
  final String merchantTransactionId;
  final String paymentType;
  final String itemName;
  @override
  State<PhonepePaymentScreen> createState() => _PhonepePaymentScreenState();
}

class _PhonepePaymentScreenState extends State<PhonepePaymentScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      applicationNameForUserAgent:
          // iOS user agent string
          'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148',
      javaScriptEnabled: true,
      supportZoom: false,
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      userAgent:
          // Android user agent string
          'Mozilla/5.0 (Linux; Android 10; Pixel 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36',
    ),
    android: AndroidInAppWebViewOptions(
      allowFileAccess: true,
      allowContentAccess: true,
      supportMultipleWindows: true,
      thirdPartyCookiesEnabled: true,
      useHybridComposition: true,
      loadWithOverviewMode: true,
      domStorageEnabled: true,
    ),
    ios: IOSInAppWebViewOptions(
      sharedCookiesEnabled: true,
      applePayAPIEnabled: true,
    ),
  );

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  bool result = false;
  String url = '';
  double progress = 0;
  final urlController = TextEditingController();
  bool isShowWebView = false;
  String userId = '';
  String shareLink = '';
  String? initiaUrl;
  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  Connectivity connectivity = Connectivity();
  ConnectivityResult connectivityResult = ConnectivityResult.none;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  showDilogueExitPayment(context);
                },
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
        body: SafeArea(
          child: Stack(children: [
            Consumer(
              builder:
                  (context, PhonepePaymentController phhonepeProvider, child) {
                return result
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : InAppWebView(
                        key: webViewKey,
                        initialUrlRequest: URLRequest(
                          url: Uri.parse(widget.paymentUrl),
                        ),
                        initialOptions: options,
                        pullToRefreshController: pullToRefreshController,
                        onLoadStart: (controller, url) async {
                          setState(() {
                            this.url = url.toString();
                          });
                        },
                        androidOnPermissionRequest:
                            (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          log(navigationAction.request.url.toString());
                          var uri = navigationAction.request.url!;

                          if (uri.scheme.contains('check_phonepe_status')) {
                            setState(() {
                              result = true;
                            });
                            webViewController?.goBack();
                            webViewController?.goBack();
                            phhonepeProvider
                                .checkWalletAddPaymnetverify(context,
                                    txId: widget.merchantTransactionId)
                                .then((value) {
                              if (value.isNotEmpty) {
                                String msg = '';
                                if (value[0].status == '0') {
                                  msg = 'Transaction Pending';
                                } else if (value[0].status == '2') {
                                  msg = 'Transaction Successfull';
                                } else {
                                  msg = 'Transaction Failed';
                                }

                                if (value[0].status == '0' ||
                                    value[0].status == '2') {
                                  if (widget.paymentType == 'prime' ||
                                      widget.paymentType == 'pro') {
                                    // context
                                    //     .read<UserProvider>()
                                    //     .getUserInformation(context);
                                    // context
                                    //     .read<InitialHomeProvider>()
                                    //     .getUserInformation(context);
                                    // successPopUp(context);
                                    // Future.delayed(const Duration(seconds: 2))
                                    //     .then((value) {
                                    //   Navigator.of(context).pushAndRemoveUntil(
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const Dashboard(),
                                    //       ),
                                    //       (route) => false);
                                    // });

                                    // setSnackbar(msg, context);
                                  } else {
                                    if (widget.paymentType == 'brand') {
                                      // Navigator.of(context)
                                      //     .pushReplacement(MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       UtilitypaymentSuccess(
                                      //     amount: widget.amount,
                                      //     number: 'Brand Voucher Purchase',
                                      //     payMode: 'Online Payment',
                                      //     payType: 'Wallet',
                                      //     refId: value[0].providerReferenceId ??
                                      //         '',
                                      //     rechrgeName: widget.itemName,
                                      //     status: value[0].status == '2'
                                      //         ? 'SUCCESS'
                                      //         : value[0].status == '1'
                                      //             ? 'Failed'
                                      //             : 'Pending',
                                      //   ),
                                      // ));
                                    } else {
                                      //   Navigator.of(context)
                                      //       .pushReplacement(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         UtilitypaymentSuccess(
                                      //       amount: widget.amount,
                                      //       number: 'Wallet Recharge',
                                      //       payMode: 'Online Payment',
                                      //       payType: 'Wallet',
                                      //       refId: value[0].providerReferenceId ??
                                      //           '',
                                      //       rechrgeName: 'Wallet Recharge',
                                      //       status: value[0].status == '2'
                                      //           ? 'SUCCESS'
                                      //           : value[0].status == '1'
                                      //               ? 'Failed'
                                      //               : 'Pending',
                                      //     ),
                                      //   ));
                                    }
                                  }
                                } else {
                                  //  setSnackbar(msg, context);
                                  Navigator.of(context).pop();
                                }
                              }
                            });
                            log('shouldOverrideUrlLoading');

                            return NavigationActionPolicy.CANCEL;
                          } else if (uri.scheme
                              .contains('payment_status=Failed')) {
                            Navigator.of(context).pop();

                            return NavigationActionPolicy.CANCEL;
                          }
                          return NavigationActionPolicy.ALLOW;
                        },
                        onLoadStop: (controller, url) async {
                          log(url.toString());

                          if (url.toString().contains('check_phonepe_status')) {
                            setState(() {
                              result = true;
                            });
                            log('shouldOverrideUrlLoading  onLoadStop');
                            webViewController?.goBack();
                            webViewController?.goBack();
                            phhonepeProvider
                                .checkWalletAddPaymnetverify(context,
                                    txId: widget.merchantTransactionId)
                                .then((value) {
                              if (value.isNotEmpty) {
                                String msg = '';
                                if (value[0].status == '0') {
                                  msg = 'Transaction Pending';
                                } else if (value[0].status == '2') {
                                  msg = 'Transaction Successfull';
                                } else {
                                  msg = 'Transaction Failed';
                                }

                                if (value[0].status == '0' ||
                                    value[0].status == '2') {
                                  if (widget.paymentType == 'prime' ||
                                      widget.paymentType == 'pro') {
                                    // context
                                    //     .read<UserProvider>()
                                    //     .getUserInformation(context);
                                    // context
                                    //     .read<InitialHomeProvider>()
                                    //     .getUserInformation(context);
                                    // successPopUp(context);
                                    // Future.delayed(const Duration(seconds: 2))
                                    //     .then((value) {
                                    //   Navigator.of(context).pushAndRemoveUntil(
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const Dashboard(),
                                    //       ),
                                    //       (route) => false);
                                    // });

                                    // setSnackbar(msg, context);
                                  } else {
                                    //setSnackbar(msg, context);

                                    if (widget.paymentType == 'brand') {
                                      // Navigator.of(context)
                                      //     .pushReplacement(MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       UtilitypaymentSuccess(
                                      //     amount: widget.amount,
                                      //     number: 'Brand Voucher Purchase',
                                      //     payMode: 'Online Payment',
                                      //     payType: 'Wallet',
                                      //     refId: value[0].providerReferenceId ??
                                      //         '',
                                      //     rechrgeName: widget.itemName,
                                      //     status: value[0].status == '2'
                                      //         ? 'SUCCESS'
                                      //         : value[0].status == '1'
                                      //             ? 'Failed'
                                      //             : 'Pending',
                                      //   ),
                                      // ));
                                    } else {
                                      // Navigator.of(context)
                                      //     .pushReplacement(MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       UtilitypaymentSuccess(
                                      //     amount: widget.amount,
                                      //     number: 'Wallet Recharge',
                                      //     payMode: 'Online Payment',
                                      //     payType: 'Wallet',
                                      //     refId: value[0].providerReferenceId ??
                                      //         '',
                                      //     rechrgeName: 'Wallet Recharge',
                                      //     status: value[0].status == '2'
                                      //         ? 'SUCCESS'
                                      //         : value[0].status == '1'
                                      //             ? 'Failed'
                                      //             : 'Pending',
                                      //   ),
                                      // ));
                                    }
                                  }
                                } else {
                                  //  setSnackbar(msg, context);
                                  Navigator.of(context).pop();
                                }
                              } else {}
                            });
                          }

                          pullToRefreshController!.endRefreshing();
                          setState(() {
                            this.url = url.toString();
                          });
                        },
                        onProgressChanged: (controller, progress) {
                          if (progress == 100) {
                            pullToRefreshController?.endRefreshing();
                          }
                          setState(() {
                            this.progress = progress / 100;
                          });
                        },
                        onUpdateVisitedHistory:
                            (controller, url, androidIsReload) {
                          setState(() {
                            this.url = url.toString();
                          });
                        },
                        onConsoleMessage: (controller, consoleMessage) {},
                      );
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container()
          ]),
        ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await webViewController?.canGoBack() ?? false) {
      webViewController?.goBack();
      return Future.value(false);
    } else {
      return Future.value(false);
    }
  }

  void successPopUp(context) async {
    await showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 350,
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/staticimage/sucprim.jpeg'))),
                ),
                const Text(
                  'Congratulations 🎉',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showDilogueExitPayment(
    BuildContext context,
  ) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 130.0,
        width: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppSpacing.ksizedBox20,
            const Text(
              'Do You Want To Exit From Payment?',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AppSpacing.ksizedBoxW20,
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    )),
                AppSpacing.ksizedBoxW20,
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'YES',
                    style: TextStyle(
                        color: AppColoring.errorPopUp, fontSize: 14.0),
                  ),
                ),
                AppSpacing.ksizedBoxW20,
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => errorDialog,
    );
  }
}
