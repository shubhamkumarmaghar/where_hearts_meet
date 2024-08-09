import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../consts/app_screen_size.dart';

class EventCardShimmer extends StatelessWidget {
  const EventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight*0.4,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return Container(
            width: screenWidth * 0.55,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.25),
                  highlightColor: Colors.white.withOpacity(0.5),
                  child: Container(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.25),
                  highlightColor: Colors.white.withOpacity(0.5),
                  child: Container(
                    height: screenHeight * 0.02,
                    width: screenWidth * 0.35,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.06,
                      child: Stack(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.white.withOpacity(0.25),
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              height: screenHeight * 0.06,
                              width: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 3)),
                            ),
                          ),
                          Positioned(
                            right: screenWidth * 0.05,
                            child: Shimmer.fromColors(
                              baseColor: Colors.white.withOpacity(0.25),
                              highlightColor: Colors.white.withOpacity(0.5),
                              child: Container(
                                height: screenHeight * 0.06,
                                width: screenHeight * 0.06,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white, width: 3)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.white.withOpacity(0.25),
                      highlightColor: Colors.white.withOpacity(0.5),
                      child: Container(
                        height: screenHeight*0.03,
                        width: screenWidth*0.03,
                        margin: EdgeInsets.only(right: screenWidth*0.02),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: 3,
      ),
    );
  }
}
