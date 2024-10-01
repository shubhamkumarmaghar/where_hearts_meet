import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../consts/app_screen_size.dart';

class EventListShimmer extends StatelessWidget {
  const EventListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: screenHeight * 0.03, top: screenHeight * 0.02),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.5),
                    child: Container(
                      height: 200,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white.withOpacity(0.25),
                      highlightColor: Colors.white.withOpacity(0.4),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                  Positioned(
                    right: screenWidth * 0.03,
                    bottom: screenHeight * 0.01,
                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.white.withOpacity(0.25),
                          highlightColor: Colors.white.withOpacity(0.4),
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenHeight * 0.06,
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.01,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.white.withOpacity(0.25),
                          highlightColor: Colors.white.withOpacity(0.4),
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenHeight * 0.06,
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.4),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      height: 20,
                      width: screenWidth * 0.5,
                    ),
                  ),
                  const Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.4),
                    child: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.white,
                      height: 20,
                      width: screenWidth * 0.25,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.4),
                    child: Container(
                      width: screenWidth * 0.5,
                      height: 20,
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.4),
                    child: Container(
                      width: screenWidth * 0.25,
                      height: 20,
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.25),
                highlightColor: Colors.white.withOpacity(0.4),
                child: Container(
                  width: screenWidth * 0.8,
                  height: 20,
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => Column(
          children: [
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Shimmer.fromColors(
              baseColor: Colors.white.withOpacity(0.25),
              highlightColor: Colors.white.withOpacity(0.4),
              child: Container(
                width: screenWidth,
                height: 2,
                color: Colors.white,
                alignment: Alignment.centerLeft,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.015,
            )
          ],
        ),
        itemCount: 4,
      ),
    );
  }
}
