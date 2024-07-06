import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/onboarding_model.dart';
import '../view/onboarding_view.dart';

class OnboardingCardImageWidget extends StatelessWidget {
  final OnboardingModel onboardingModel;

  const OnboardingCardImageWidget({super.key, required this.onboardingModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      /// space from white container
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.6,
      width: size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            buildImage(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() => SizedBox.expand(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Image.asset(onboardingModel.img, fit: BoxFit.fill),
        ),
      );
}
