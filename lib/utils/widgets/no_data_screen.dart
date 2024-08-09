import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';

class NoDataScreen extends StatelessWidget {
  final String? message;

  const NoDataScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      message ?? 'No Data found!.',
      textAlign: TextAlign.center,
      style: textStyleDangrek(),
    ));
  }
}
