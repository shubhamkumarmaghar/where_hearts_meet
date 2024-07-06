import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../../guest_dashboard/view/guest_dashboard.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../model/onboarding_model.dart';
import 'onboarding_image_widget.dart';
import '../view/onboarding_view.dart';
import '../../utils/consts/color_const.dart';
import 'expanded_onboarding.dart';

class IntroWidget extends StatefulWidget {
  final OnboardingModel onboardingModel;

  const IntroWidget({super.key, required this.onboardingModel});

  @override
  _IntroWidgetState createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.9 : size.width * 0.7,
            height: isExpanded ? size.height * 0.66 : size.height * 0.5,
            child: ExpandedContentWidget(onboardingModel: widget.onboardingModel),
          ),
          Visibility(
            visible: widget.onboardingModel.text.contains('click away'),
            child: AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              bottom: isExpanded ? 40 : 100,
              width: isExpanded ? size.width * 0.9 : size.width * 0.7,
              height: isExpanded ? size.height * 0.66 : size.height * 0.5,
              child: GestureDetector(
                onTap: () {
                  GetStorage().write(onboarding, true);
                  Get.offAll( OnboardingScreen());
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      size: 50,
                      color: primaryColor,
                    )),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: () {},
              child: OnboardingCardImageWidget(
                onboardingModel: widget.onboardingModel,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
