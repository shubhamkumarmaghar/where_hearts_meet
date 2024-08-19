import 'package:flutter/material.dart';

class LineIndicator extends StatelessWidget {
  final int totalCount;
  final int currentIndex;
  final Color selectedColor;
  final Color defaultColor;
  final EdgeInsetsGeometry? padding;

  const LineIndicator(
      {super.key,
        required this.totalCount,
        required this.currentIndex,
        this.selectedColor = Colors.white,
        this.defaultColor = Colors.grey,
        this.padding});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 6,
      padding: padding,
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: List.generate(totalCount, (index){
            return Expanded(
              child: Container(
                margin: index == 0 ? null :const EdgeInsets.only(left: 5),
                //width: indicatorWidth,
                decoration: BoxDecoration(
                  color: currentIndex >= index ? selectedColor : defaultColor,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}