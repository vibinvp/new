import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:paystome/controller/profile/profile_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/HTML_Page/tems_contact_pages.dart';
import 'package:paystome/view/Orders/my_orders.dart';
import 'package:paystome/view/Orders/my_videos_screen.dart';
import 'package:paystome/view/Profile/edit_profile.dart';
import 'package:paystome/view/Profile/update_bankdetilas.dart';
import 'package:paystome/view/Refferal/screen_refferal.dart';
import 'package:paystome/view/contact_us.dart';
import 'package:paystome/widget/pop_up_widget.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late ProfileController profileController;
  @override
  void initState() {
    profileController = Provider.of<ProfileController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getUserDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Column(
            children: [
              AppSpacing.ksizedBox15,
              profileData(context),
              AppSpacing.ksizedBox20,
              //   mainItemWidget(),
              //   AppSpacing.ksizedBox30,
              _getDrawerItem('My Profile', IconlyBold.profile, 2, context),
              _getDrawerItem(
                  'Bank Detilas', Icons.account_balance_rounded, 10, context),
              _getDrawerItem('My Videos', IconlyBold.video, 1, context),
              //  _getDrawerItem('Earnings', IconlyBold.wallet, 3, context),
              // _getDrawerItem(
              //     'Privacy Policy', IconlyBold.info_circle, 4, context),
              //  _getDrawerItem('Faqs', IconlyBold.chat, 5, context),
              _getDrawerItem('Terms & Conditions', IconlyBold.lock, 6, context),
              _getDrawerItem('Contact Us', IconlyBold.call, 7, context),
              _getDrawerItem('Reffer & Earn', IconlyBold.send, 9, context),
              _getDrawerItem('Logout', IconlyBold.logout, 8, context),
            ],
          ),
        )),
      ),
    );
  }

  Widget mainItemWidget() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              RouteConstat.nextNamed(context, const EditProfileScreen());
            },
            child: const Card(
              elevation: 5,
              // color: AppColoring.primaryWhite.withOpacity(0.4),
              child: SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      IconlyBold.profile,
                      color: AppColoring.kAppColor,
                      size: 32,
                    ),
                    Text(
                      'My Profile',
                      style: TextStyle(
                        color: AppColoring.kAppColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AppSpacing.ksizedBoxW10,
        Expanded(
          child: InkWell(
            onTap: () {
              RouteConstat.nextNamed(context, const ScreenMyOrders());
            },
            child: const Card(
              elevation: 5,
              // color: AppColoring.primaryWhite.withOpacity(0.4),
              child: SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      IconlyBold.video,
                      color: AppColoring.kAppColor,
                      size: 32,
                    ),
                    Text(
                      'My Videos',
                      style: TextStyle(
                        color: AppColoring.kAppColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AppSpacing.ksizedBoxW10,
        Expanded(
          child: InkWell(
            onTap: () {
              RouteConstat.nextNamed(context, const BankDetilasScreen());
            },
            child: const Card(
              elevation: 5,
              // color: AppColoring.primaryWhite.withOpacity(0.4),
              child: SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.account_balance_outlined,
                      color: AppColoring.kAppColor,
                      size: 32,
                    ),
                    Text(
                      'Bank Detilas',
                      style: TextStyle(
                        color: AppColoring.kAppColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getDrawerItem(
      String title, IconData? icon, int index, BuildContext context) {
    return ListTile(
      trailing: const Icon(
        IconlyBold.arrow_right_2,
        color: AppColoring.kAppColor,
      ),
      leading: Icon(icon),
      dense: true,
      title: Text(
        title == 'Faqs' ? 'FAQs' : title,
        style: const TextStyle(
          color: AppColoring.textDark,
          fontSize: 15,
        ),
      ),
      onTap: () {
        if (index == 1) {
          RouteConstat.nextNamed(context, const ScreenMyOrders());
        } else if (index == 2) {
          RouteConstat.nextNamed(context, const EditProfileScreen());
        } else if (index == 3) {
        } else if (index == 4) {
          RouteConstat.nextNamed(
              context,
              TermsAndConditionsHtmlView(
                title: title,
                code: title[0],
              ));
        } else if (index == 5) {
          RouteConstat.nextNamed(
              context,
              TermsAndConditionsHtmlView(
                title: title,
                code: title[0],
              ));
        } else if (index == 6) {
          RouteConstat.nextNamed(
              context,
              TermsAndConditionsHtmlView(
                title: title,
                code: title[0],
              ));
        } else if (index == 7) {
          RouteConstat.nextNamed(
              context,
              const ScreenContactUs(
                  // title: title,
                  // code: title[0],
                  ));
        } else if (index == 9) {
          RouteConstat.nextNamed(context, const ReferEarn());
        } else if (index == 10) {
          RouteConstat.nextNamed(context, const BankDetilasScreen());
        } else if (index == 8) {
          logoutPOPUP(context);
        }
      },
    );
  }

  Widget profileData(context) {
    return InkWell(
      onTap: () {
        RouteConstat.nextNamed(context, const EditProfileScreen());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Consumer(
                builder: (context, ProfileController value, child) {
                  return value.userDetailsModel == null
                      ? const SingleItemSimmer()
                      : Row(
                          children: [
                            value.profilePic.isNotEmpty
                                ? Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: CachedNetworkImage(
                                          errorWidget: (context, url, error) {
                                            return const Icon(Icons.error);
                                          },
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) {
                                            return const SingleBallnerItemSimmer();
                                          },
                                          fit: BoxFit.fill,
                                          imageUrl:
                                              // ApiBaseConstant.baseMainUrl +
                                              //     AppConstant.profileImageUrl +
                                              value.profilePic),
                                    ),
                                  )
                                : Container(
                                    height: 130,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              Utils.setPngPath('logo'))),
                                    ),
                                  ),
                            AppSpacing.ksizedBoxW20,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value.userDetailsModel!.data!.firstname ==
                                        ''
                                    ? ''
                                    : value.userDetailsModel!.data!.firstname ??
                                        ''),
                                AppSpacing.ksizedBox5,
                                Text(value.userDetailsModel!.data!.email == ''
                                    ? ''
                                    : value.userDetailsModel!.data!.email ??
                                        ''),
                              ],
                            )
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  logoutPOPUP(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationDialog(
        icon: Utils.setPngPath('warning').toString(),
        title: 'Are you sure to confirm?',
        description: 'Do you want to Logout ?',
        onYesPressed: () {
          context.read<ProfileController>().appLogOut(context);
        },
      ),
    );
  }
}
