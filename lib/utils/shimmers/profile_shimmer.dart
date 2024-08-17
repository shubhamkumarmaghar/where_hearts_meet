import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../widgets/app_bar_widget.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backIcon(color: Colors.white),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.25),
                highlightColor: Colors.white.withOpacity(0.5),
                child: Container(
                  height: screenHeight * 0.025,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.25),
                highlightColor: Colors.white.withOpacity(0.5),
                child: Container(
                  height: screenHeight * 0.025,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Align(
            alignment: Alignment.center,
            child: Shimmer.fromColors(
              baseColor: Colors.white.withOpacity(0.25),
              highlightColor: Colors.white.withOpacity(0.5),
              child: Container(
                height: screenHeight * 0.15,
                width: screenHeight * 0.15,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: Shimmer.fromColors(
              baseColor: Colors.white.withOpacity(0.25),
              highlightColor: Colors.white.withOpacity(0.5),
              child: Container(
                height: screenHeight * 0.04,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.07,
          ),
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.25),
            highlightColor: Colors.white.withOpacity(0.5),
            child: Container(
              height: screenHeight * 0.06,
              width: screenWidth,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.25),
            highlightColor: Colors.white.withOpacity(0.5),
            child: Container(
              height: screenHeight * 0.06,
              width: screenWidth,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.25),
            highlightColor: Colors.white.withOpacity(0.5),
            child: Container(
              height: screenHeight * 0.06,
              width: screenWidth,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.25),
            highlightColor: Colors.white.withOpacity(0.5),
            child: Container(
              height: screenHeight * 0.06,
              width: screenWidth,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
