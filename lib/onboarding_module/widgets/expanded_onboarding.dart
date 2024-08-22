import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../model/onboarding_model.dart';
import '../view/onboarding_view.dart';

class ExpandedContentWidget extends StatelessWidget {
  final OnboardingModel onboardingModel;

 ExpandedContentWidget(
  {required this.onboardingModel}
  ) : super();

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    padding: const EdgeInsets.all(8),
    child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(onboardingModel.text,
          maxLines: 3,
          textAlign: TextAlign.center,style: TextStyle(color: primaryColor,fontSize: 26,fontWeight: FontWeight.w600),),
       SizedBox(height: 30,),
       // buildReview(location: location)
      ],
    ),
  );

}