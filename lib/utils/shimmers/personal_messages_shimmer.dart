import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/string_consts.dart';
import '../util_functions/decoration_functions.dart';

class PersonalMessagesShimmer extends StatelessWidget {
  const PersonalMessagesShimmer({super.key});

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
                    StringConsts.specialMessages,
                    style: textStyleDangrek(fontSize: 24),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.04),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.25),
                  highlightColor: Colors.white.withOpacity(0.5),
                  child: Container(
                    height: screenHeight * 0.15,
                    margin: EdgeInsets.only(
                      right: screenWidth * 0.15,
                      left: screenWidth * 0.05,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyPersonalMessagesWidget extends StatelessWidget {
  const EmptyPersonalMessagesWidget({super.key});

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
                    StringConsts.specialMessages,
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
                'No any special messages found!',
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
