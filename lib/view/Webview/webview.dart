import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen(this.title, this.url, {super.key});
  final String title;
  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  PullToRefreshController? pullToRefreshController;

  late ContextMenu contextMenu;
  double progress = 0;

  final urlController = TextEditingController();
  //Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColoring.kAppColor,
        leading: InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) async {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) async {
                        setState(() {
                          // widget.url = url.toString();
                          urlController.text = widget.url;
                        });
                      },
                      onLoadStop: (controller, url) async {
                        setState(() {
                          // widget.url = url.toString();
                          urlController.text = widget.url;
                          isLoading = false;
                        });
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController?.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = widget.url;
                        });
                      },
                      onUpdateVisitedHistory: (controller, url, isReload) {
                        setState(() {
                          //   widget.url = url.toString();
                          urlController.text = widget.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {},
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Stack(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
