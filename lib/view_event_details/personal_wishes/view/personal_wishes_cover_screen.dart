import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heart_e_homies/routes/routes_const.dart';
import 'package:heart_e_homies/utils/util_functions/decoration_functions.dart';
import 'package:heart_e_homies/view_event_details/personal_wishes/view/personal_memories_screen.dart';

import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/color_const.dart';

import '../../../utils/widgets/util_widgets/app_widgets.dart';
import '../controller/personal_memories_controller.dart';

class PersonalWishesCoverScreen extends StatefulWidget {
  const PersonalWishesCoverScreen({super.key});

  @override
  State<PersonalWishesCoverScreen> createState() => _PersonalWishesCoverScreenState();
}

class _PersonalWishesCoverScreenState extends State<PersonalWishesCoverScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalMemoriesController>(builder: (controller) {
      return Scaffold(
        body: controller.isBusy
            ? AppWidgets.getLoader()
            : Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(controller.personalWishesCoverModel != null &&
                                    controller.personalWishesCoverModel!.coverImage != null
                                ? controller.personalWishesCoverModel!.coverImage!
                                : ''),
                            fit: BoxFit.fitHeight)),
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      // appColor3.withOpacity(0.1),
                      primaryColor.withOpacity(0.2),
                      //appColor1.withOpacity(0.8),
                      primaryColor.withOpacity(0.5),
                      primaryColor.withOpacity(0.8),
                      primaryColor,
                      //appColor1,
                    ])),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpace(screenHeight * 0.5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Explore Special Feelings',
                                    style: GoogleFonts.architectsDaughter(fontSize: 45, color: Colors.white)),
                                Text(controller.personalWishesCoverModel!.message ?? '',
                                    style: GoogleFonts.architectsDaughter(fontSize: 35, color: Colors.white)),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    //left: screenWidth*0.4,
                    child: GestureDetector(
                      onTap: (() {
                        controller.personalWishesMemories(eventId: controller.eventId);
                        Get.toNamed(RoutesConst.personalMemoriesScreen);
                      }),
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(
                                  0,
                                  1,
                                ),
                                color: Colors.white,
                                spreadRadius: 3,
                                blurRadius: 5,
                                blurStyle: BlurStyle.solid,
                              )
                            ],
                          ),
                          child:  Row(
                            children: [
                              Text(
                                'Start ',
                                style: textStyleAleo(),
                              ),
                              Icon(Icons.arrow_forward,color: Colors.white,)
                            ],
                          )),
                    ),
                  )
                ],
              ),
      );
    });
  }
}
