import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paystome/controller/profile/profile_controller.dart';
import 'package:paystome/helper/core/app_spacing.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/message.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/map/screen_map.dart';
import 'package:paystome/widget/app_loader_widget.dart';
import 'package:paystome/widget/shimmer_effect.dart';
import 'package:paystome/widget/textfeild_widget.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileController profileController;
  @override
  void initState() {
    profileController = Provider.of<ProfileController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getUserDetails(context);
      profileController.isLoadUpdateUser = false;
      profileController.image = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _getActionButtons(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          "Profile Details",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Stack(fit: StackFit.loose, children: <Widget>[
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return SimpleDialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 100,
                                  ),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await profileController
                                                .getImage(ImageSource.gallery);

                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                          },
                                          child: const Column(
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: 40,
                                              ),
                                              Text('Gallery'),
                                            ],
                                          ),
                                        ),
                                        AppSpacing.ksizedBoxW30,
                                        InkWell(
                                          onTap: () async {
                                            profileController
                                                .getImage(ImageSource.camera);

                                            Navigator.of(context).pop();
                                          },
                                          child: const Column(
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                size: 40,
                                              ),
                                              Text('Camera'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            height: 110,
                            width: double.infinity,
                            // color: AppColoring.kAppBlueColor,
                            child: Center(
                              child: Consumer(
                                builder:
                                    (context, ProfileController value, child) {
                                  // profileController.imageTobase64();
                                  return value.image == null
                                      ? value.profilePic.isNotEmpty
                                          ? Stack(
                                              children: [
                                                Container(
                                                  width: 110,
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                    color: AppColoring
                                                        .kAppWhiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80),
                                                    child: CachedNetworkImage(
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return const Icon(
                                                              Icons.error);
                                                        },
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                downloadProgress) {
                                                          return const SingleBallnerItemSimmer();
                                                        },
                                                        fit: BoxFit.fill,
                                                        imageUrl:
                                                            //  ApiBaseConstant
                                                            //         .baseMainUrl +
                                                            //     AppConstant
                                                            //         .profileImageUrl +
                                                            value.profilePic),
                                                  ),
                                                ),
                                                const Positioned(
                                                  bottom: 15,
                                                  left: 80,
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        AppColoring.lightBg,
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(
                                              height: 130,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Utils.setPngPath(
                                                            'logo'))),
                                              ),
                                              child: const Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      AppColoring.lightBg,
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                      : CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.black,
                                          backgroundImage:
                                              FileImage(value.image!),
                                          child: const Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  AppColoring.lightBg,
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      HeadingAndTexFeildWidget(
                          text: 'Enter UserName',
                          heading: 'Username',
                          controller: profileController.userNameController),
                      AppSpacing.ksizedBox10,
                      HeadingAndTexFeildWidget(
                          text: 'Enter first name',
                          heading: 'First Name',
                          controller: profileController.nameController),
                      AppSpacing.ksizedBox10,
                      HeadingAndTexFeildWidget(
                          text: 'Enter last name',
                          heading: 'Last Name',
                          controller: profileController.lastnameController),
                      AppSpacing.ksizedBox10,
                      HeadingAndTexFeildWidget(
                          text: 'Enter EmailId',
                          heading: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: profileController.emailController),
                      AppSpacing.ksizedBox10,
                      HeadingAndTexFeildWidget(
                          text: 'Enter mobile no.',
                          heading: 'Mobile',
                          keyboardType: TextInputType.phone,
                          controller: profileController.mobileController),
                      AppSpacing.ksizedBox10,
                      HeadingAndTexFeildWidget(
                          text: 'Enter City',
                          heading: 'City',
                          controller: profileController.cityController),
                      const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Pincode',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'State',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextFormField(
                                    controller:
                                        profileController.pincodeController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(6)
                                    ],
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return " Please enter the pincode";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Enter Pin Code",
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColoring.primeryBorder),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: AppColoring.primeryBorder,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  controller: profileController.stateController,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return " Please enter the state";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColoring.primeryBorder),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: "Enter State",
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColoring.primeryBorder),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: AppColoring.primeryBorder,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Address',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    RouteConstat.nextNamed(
                                      context,
                                      MapScreen(
                                        latitudeController: profileController
                                            .latitudeController,
                                        longitudeController: profileController
                                            .longitudeController,
                                        addressController:
                                            profileController.addressController,
                                        cityController:
                                            profileController.cityController,
                                        pinCodeController:
                                            profileController.pincodeController,
                                        stateController:
                                            profileController.stateController,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.my_location)),
                            ],
                          )),
                      Consumer(builder: (context,
                          ProfileController profileController, child) {
                        return InkWell(
                          onTap: () {
                            if (profileController.addressController.text !=
                                    '' ||
                                profileController
                                    .addressController.text.isNotEmpty) {
                              profileController.enableMap();
                            } else {
                              RouteConstat.nextNamed(
                                context,
                                MapScreen(
                                  latitudeController:
                                      profileController.latitudeController,
                                  longitudeController:
                                      profileController.longitudeController,
                                  addressController:
                                      profileController.addressController,
                                  cityController:
                                      profileController.cityController,
                                  pinCodeController:
                                      profileController.pincodeController,
                                  stateController:
                                      profileController.stateController,
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              enabled: profileController.enable,
                              maxLines: 5,
                              keyboardType: TextInputType.text,
                              controller: profileController.addressController,
                              validator: (String? value) {
                                if (value == null ||
                                    value.isEmpty && value.length > 10) {
                                  return " Please enter the  address";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Address',
                                labelText: 'Enter the address',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColoring.primeryBorder),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      AppSpacing.ksizedBox50,
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0, bottom: 20),
      child: Consumer(
        builder: (context, ProfileController value, child) {
          return value.isLoadUpdateUser
              ? const LoadreWidget()
              : SizedBox(
                  height: 40,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      if (value.mobileController.text.length != 10) {
                        showToast(
                            msg: 'Enter 10 digit number',
                            clr: AppColoring.errorPopUp);
                      } else if (value.userNameController.text == '' ||
                          value.userNameController.text.isEmpty) {
                        showToast(
                            msg: 'Username is reqiured',
                            clr: AppColoring.errorPopUp);
                      } else if (value.nameController.text == '' ||
                              value.nameController.text.isEmpty ||
                              value.emailController.text == '' ||
                              value.emailController.text.isEmpty ||
                              value.lastnameController.text == '' ||
                              value.lastnameController.text.isEmpty

                          // value.stateController.text == '' ||
                          // value.stateController.text.isEmpty ||
                          // value.lastnameController.text == '' ||
                          // value.lastnameController.text.isEmpty ||
                          // value.addressController.text == '' ||
                          // value.addressController.text.isEmpty ||
                          // value.dropDownValueGender == '' ||
                          // value.dropDownValueGender == null
                          ) {
                        showToast(
                            msg: 'Fill all the fields correctly',
                            clr: AppColoring.errorPopUp);
                      } else {
                        value.updateUser(context);
                      }
                    },
                  ));
        },
      ),
    );
  }

  bool camera = false;

  Widget submitImage() {
    return InkWell(onTap: () {}, child: const Text("Submit"));
  }
}

class HeadingAndTexFeildWidget extends StatelessWidget {
  const HeadingAndTexFeildWidget({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.text,
    required this.heading,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String text;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      heading,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColoring.primeryBorder),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextfeildWidget(
                    text: text,
                    controller: controller,
                    keyboardType: keyboardType,
                  ),
                )),
              ],
            )),
      ],
    );
  }
}
