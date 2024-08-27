import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/string_consts.dart';
import '../util_functions/decoration_functions.dart';

class PersonalDecorationsShimmer extends StatelessWidget {
  const PersonalDecorationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Row(
              children: [
                backIcon(),
                const Spacer(),
                Text(
                  StringConsts.personalDecorations,
                  style: textStyleDangrek(fontSize: 24),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Shimmer.fromColors(
              baseColor: Colors.white.withOpacity(0.25),
              highlightColor: Colors.white.withOpacity(0.5),
              child: Container(
                height: screenHeight * 0.08,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        height: screenHeight * 0.3,
                        width: screenWidth,
                        child: Shimmer.fromColors(
                          baseColor: Colors.white.withOpacity(0.25),
                          highlightColor: Colors.white.withOpacity(0.5),
                          child: Container(
                            height: screenHeight * 0.08,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                          ),
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class EmptyPersonalDecorationsWidget extends StatelessWidget {
  const EmptyPersonalDecorationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: appColor1,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                backIcon(),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text(
                    StringConsts.personalDecorations,
                    style: textStyleDangrek(fontSize: 24),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'No any decoration images/videos found!',
                textAlign: TextAlign.center,
                style: textStyleDangrek(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
