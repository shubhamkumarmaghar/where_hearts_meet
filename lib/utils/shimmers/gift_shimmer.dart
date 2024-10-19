import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../consts/app_screen_size.dart';

class GiftShimmer extends StatelessWidget {
  const GiftShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
      itemBuilder: (context, index) {
        return Container(
          width: screenWidth,
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.5),
                    child: Container(
                      height: screenHeight * 0.1,
                      width: screenHeight * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.white.withOpacity(0.25),
                        highlightColor: Colors.white.withOpacity(0.5),
                        child: Container(
                          height: screenHeight * 0.025,
                          width: screenWidth * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
                          height: screenHeight * 0.025,
                          width: screenWidth * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
                          height: screenHeight * 0.04,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.25),
                highlightColor: Colors.white.withOpacity(0.4),
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.025,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.25),
                highlightColor: Colors.white.withOpacity(0.4),
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.025,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
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
