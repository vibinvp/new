import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paystome/helper/core/color_constant.dart';

class LoadreWidget extends StatelessWidget {
  const LoadreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color:
                  index.isEven ? AppColoring.kAppColor : AppColoring.kAppColor,
            ),
          );
        },
      ),
    );
  }
}
