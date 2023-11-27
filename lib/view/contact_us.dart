import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:paystome/controller/Settings/settind_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenContactUs extends StatefulWidget {
  const ScreenContactUs({super.key});

  @override
  State<ScreenContactUs> createState() => _ScreenContactUsState();
}

class _ScreenContactUsState extends State<ScreenContactUs> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer(
          builder: (context, SettingController value, child) {
            return value.isLoadgetDetails
                ? const LoadreWidget()
                : value.storeDetailsList.isEmpty
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : Column(
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: AppColoring.primaryWhite.withOpacity(.5),
                            title: SelectableText(
                                value.storeDetailsList[0].email ?? ''),
                            trailing: InkWell(
                              onTap: () {
                                try {
                                  launchUrl(Uri.parse(
                                      'mailto:${value.storeDetailsList[0].email}'));
                                } catch (e) {
                                  showToast(
                                      msg: 'Launch Faild',
                                      clr: AppColoring.errorPopUp);
                                }
                              },
                              child: const Icon(IconlyBold.message),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: AppColoring.primaryWhite.withOpacity(.5),
                            title: SelectableText(
                                value.storeDetailsList[0].customerCare ?? ''),
                            trailing: InkWell(
                              onTap: () {
                                try {
                                  launchUrl(Uri.parse(value
                                          .storeDetailsList[0].customerCare
                                          .toString()
                                          .startsWith('+91')
                                      ? 'tel:${value.storeDetailsList[0].customerCare}'
                                      : 'tel:+91${value.storeDetailsList[0].customerCare}'));
                                } catch (e) {
                                  showToast(
                                      msg: 'Launch Faild',
                                      clr: AppColoring.errorPopUp);
                                }
                              },
                              child: const Icon(IconlyBold.call),
                            ),
                          ),
                          AppSpacing.ksizedBox10,
                        ],
                      );
          },
        ),
      ),
    );
  }
}
