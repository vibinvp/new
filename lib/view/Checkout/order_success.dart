import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/routes.dart';
import 'package:paystome/utility/utils.dart';
import 'package:paystome/view/Dashboard/screen_dashboard.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StateSuccess();
  }
}

class StateSuccess extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          "ORDER PLACED",
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: AppColoring.kAppColor,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Utils.setGifPath('download'),
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     'SERVICE BOOKED',
            //     style: Theme.of(context).textTheme.titleLarge,
            //   ),
            // ),
            const Text(
              'SUCCESSFULL',
              style: TextStyle(
                color: AppColoring.textDim,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 28.0),
              child: CupertinoButton(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    alignment: FractionalOffset.center,
                    decoration: const BoxDecoration(
                      color: AppColoring.kAppColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'CONTINUE',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColoring.kAppWhiteColor,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  onPressed: () {
                    RouteConstat.nextRemoveUntileNamed(
                        context, const DashboardScreen());
                  }),
            )
          ],
        )),
      ),
    );
  }
}
