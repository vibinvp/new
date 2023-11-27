import 'package:flutter/material.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                .map(
                  (_) => Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          color: AppColoring.kAppWhiteColor,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 18.0,
                                color: AppColoring.kAppWhiteColor,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: AppColoring.kAppWhiteColor,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                              ),
                              Container(
                                width: 100.0,
                                height: 8.0,
                                color: AppColoring.kAppWhiteColor,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                              ),
                              Container(
                                width: 20.0,
                                height: 8.0,
                                color: AppColoring.kAppWhiteColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ShimmerEffectGridview extends StatelessWidget {
  const ShimmerEffectGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(6, (index) => _buildShimmerBox()),
      ),
    );
  }

  Widget _buildShimmerBox() {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(2.0),
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class SingleItemSimmer extends StatelessWidget {
  const SingleItemSimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                color: AppColoring.kAppWhiteColor,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 18.0,
                      color: AppColoring.kAppWhiteColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: AppColoring.kAppWhiteColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    Container(
                      width: 100.0,
                      height: 8.0,
                      color: AppColoring.kAppWhiteColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    Container(
                      width: 20.0,
                      height: 8.0,
                      color: AppColoring.kAppWhiteColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleBallnerItemSimmer extends StatelessWidget {
  const SingleBallnerItemSimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 180.0,
            decoration: BoxDecoration(
                color: AppColoring.kAppWhiteColor,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}

class SimmerSingleProduct extends StatelessWidget {
  const SimmerSingleProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: AppColoring.kAppWhiteColor,
        ),
      ),
    );
  }
}
