import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:paystome/controller/Settings/settind_controller.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsHtmlView extends StatefulWidget {
  const TermsAndConditionsHtmlView(
      {super.key, required this.title, required this.code});

  final String title;
  final String code;
  @override
  State<TermsAndConditionsHtmlView> createState() =>
      _TermsAndConditionsHtmlViewState();
}

class _TermsAndConditionsHtmlViewState
    extends State<TermsAndConditionsHtmlView> {
  late SettingController settingController;
  bool camera = false;
  @override
  void initState() {
    settingController = Provider.of<SettingController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      settingController.getStoreDetails(context);
    });
    super.initState();
  }

//==============================================================================
//============================= Build Method ===================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<SettingController>(
        builder: (context, value, child) {
          return value.isLoadgetDetails
              ? const LoadreWidget()
              : value.storeDetailsList.isEmpty
                  ? const Center(
                      child: Text('No Data'),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: HtmlWidget(
                          widget.code == 'P'
                              ? value.storeDetailsList[0].privacyPolicy ??
                                  'No Details Found!'
                              : widget.code == 'F'
                                  ? value.storeDetailsList[0].privacyPolicy ??
                                      'No Details Found!'
                                  : widget.code == 'T'
                                      ? value.storeDetailsList[0]
                                              .termsConditions ??
                                          'No Details Found!'
                                      : widget.code == 'C'
                                          ? value.storeDetailsList[0]
                                                  .contactUs ??
                                              'No Details Found!'
                                          : 'No Details Found!',
                          onErrorBuilder: (context, element, error) =>
                              Text('$element error: $error'),
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  const SizedBox(
                            height: 600,
                            child: LoadreWidget(),
                          ),

                          onTapUrl: (url) {
                            launchUrl(Uri.parse(url));
                            return true;
                          },

                          renderMode: RenderMode.column,

                          // set the default styling for text
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ]));
        },
      ),
    );
  }
}
