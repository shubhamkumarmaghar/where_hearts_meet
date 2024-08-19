import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/preview_event/controller/created_memories_preview_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';

import '../../utils/widgets/custom_photo_view.dart';

class CreatedMemoriesPreviewScreen extends StatelessWidget {
  const CreatedMemoriesPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatedMemoriesPreviewController>(
      builder: (controller) {
        return Scaffold(
          body: BaseContainer(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  Text(
                    'Memories',
                    style: textStyleDangrek(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Container(
                    //padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        //physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.memoriesList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 1),
                        itemBuilder: (BuildContext context, int index) {
                          var data = controller.memoriesList[index];
                          return Container(
                            height: screenHeight * 0.3,
                            child: Stack(
                              children: [
                                Container(
                                  height: screenHeight * 0.3,
                                  width: screenWidth,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                    child: cachedImage(imageUrl: data.file ?? '', boxFit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: screenHeight * 0.06,
                                    width: screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Colors.black.withOpacity(0.5),
                                          Colors.black.withOpacity(0.6),
                                          Colors.black.withOpacity(0.8),
                                          Colors.black,
                                          Colors.black
                                        ])),
                                    child: Text(
                                      data.description ?? '',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyleAleo(fontSize: 14, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
