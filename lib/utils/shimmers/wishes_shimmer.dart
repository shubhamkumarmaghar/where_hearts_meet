import 'package:flutter/material.dart';
import 'package:heart_e_homies/utils/consts/color_const.dart';
import 'package:shimmer/shimmer.dart';

import '../consts/app_screen_size.dart';

class WishesShimmer extends StatelessWidget {
  const WishesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 30),
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          child: SizedBox(
            width: screenWidth,
            child: Column(
              children: [
                Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: primaryColor.withOpacity(0.25),
                      highlightColor: primaryColor.withOpacity(0.4),
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.35,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: primaryColor.withOpacity(0.25),
                            highlightColor: primaryColor.withOpacity(0.5),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: primaryColor),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Shimmer.fromColors(
                            baseColor: primaryColor.withOpacity(0.25),
                            highlightColor: primaryColor.withOpacity(0.5),
                            child: Container(
                              height: screenHeight * 0.02,
                              width: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Shimmer.fromColors(
                            baseColor: primaryColor.withOpacity(0.25),
                            highlightColor: primaryColor.withOpacity(0.5),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: 3,
    );
  }
}
