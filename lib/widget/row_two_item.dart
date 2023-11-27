import 'package:flutter/material.dart';

class RowTwoItemWidget extends StatelessWidget {
  const RowTwoItemWidget({
    super.key,
    required this.text1,
    required this.text2,
    this.fontSize1,
    this.fontSize2,
    this.color1,
    this.color2,
    this.fontWeight1,
    this.fontWeight2,
  });
  final String text1;
  final String text2;
  final double? fontSize1;
  final double? fontSize2;
  final Color? color1;
  final Color? color2;
  final FontWeight? fontWeight1;
  final FontWeight? fontWeight2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text1,
              style: TextStyle(
                fontSize: fontSize1 ?? 18,
                color: color1,
                fontWeight: fontWeight1,
              ),
            ),
          ),
        
          Text(
            text2,
            style: TextStyle(
              fontSize: fontSize2 ?? 15,
              color: color2,
              fontWeight: fontWeight2,
            ),
          ),
        ],
      ),
    );
  }
}
