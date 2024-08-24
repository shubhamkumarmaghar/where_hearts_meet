import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:where_hearts_meet/player/view/video_player_screen.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/text_styles/custom_text_styles.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/util_functions/app_pickers.dart';
import '../../../utils/widgets/util_widgets/app_widgets.dart';
import '../controller/PersonalWishesController.dart';

class GetPersonalWishScreen extends StatefulWidget {
  const GetPersonalWishScreen({super.key});

  @override
  State<GetPersonalWishScreen> createState() => _GetPersonalWishScreenState();
}

class _GetPersonalWishScreenState extends State<GetPersonalWishScreen> {


int indexNo=0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalWishesController>(
      builder: (controller){
        return  Scaffold(
          body: controller.isBusy
              ? AppWidgets.getLoader()
              : Stack(
            children: [
              Column(
                children: [
                  heightSpace(screenHeight * 0.08),
                   CircleAvatar(backgroundImage: NetworkImage(controller.homeController.eventDetails!.coverPic??""), radius: 40),
                  heightSpace(screenHeight * 0.01),
                  getPrimaryText(text: controller.homeController.nameText, fontSize: 20),
                  getPrimaryText(text: formatDateTime(dateTime: controller.homeController.birthday.toString(),format: 'dd-MMM-yyyy')),
                  heightSpace(screenHeight * 0.01),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: getPrimaryText(
                              text: 'Memories', textColor: Colors.white),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RoutesConst.personalMessagesScreen,arguments:controller.eventId );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: getPrimaryText(
                                text: 'Messages', textColor: Colors.grey),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            AppWidgets.getToast(message: 'Coming soon!!',color: primaryColor);
                          },
                          child:Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: getPrimaryText(
                              text: 'For you', textColor: Colors.grey),
                        ),),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: screenHeight * 0.25,
                      width: screenWidth,
                      decoration:  BoxDecoration(
                          color: primaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(25),
                          )),
                      child: ListView(
                          children: [
                            heightSpace(screenHeight*0.02),
                            getPrimaryText(text: controller.memoriesList[indexNo].description??"",
                                textColor: Colors.white)
                          ]),
                    ),
                  )
                ],
              ),
              Positioned(
                top: Get.height * 0.33,
                child: SizedBox(
                  width: screenWidth,
                  // height: 400,
                  child:
                  /* InfiniteCarousel.builder(
                    scrollBehavior: kIsWeb
                        ? ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        // Allows to swipe in web browsers
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse
                      },
                    ) : null,

                    itemCount: controller.timeLineModel.value.images!.length,
                    itemExtent:  200,
                    anchor: 0.01,
                    itemBuilder:(context, itemIndex, realIndex){
                      var image = controller.timeLineModel.value.images;
                      return itemIndex != 0?
                      Container(
                                 // width: screenWidth*0.6,
                                //  height: Get.height*0.75,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(image![itemIndex]),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ): Container(
                        // width: screenWidth*0.6,
                        //  height: Get.height*0.75,

                        margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(image![itemIndex]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                 // loop: true,
                  velocityFactor: 0.15,
                  center: false,



                ),*/
                  CarouselSlider(
                    options: CarouselOptions(
                      height: Get.height * 0.48,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      enlargeFactor: 0.25,
                      //autoPlay: true,
                      //aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      // enableInfiniteScroll: true,
                      disableCenter: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.65,
                      //  clipBehavior: Clip.none,
                      pageSnapping: false,
                      onPageChanged: (index,reason){
                        log(' change page data $indexNo  $index');
                        indexNo = index;
                        controller.update();
                        log(' change page data $indexNo  $index');
                        setState(() {
                          log('   $index');
                        });
                      },


                    ),
                    items: controller.memoriesList.map((path) {
                      return Builder(
                        builder: (BuildContext context) {
                          var data = path.file;

                          return path.fileType.toString() =='image'?
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(data!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ): Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: VideoPlayerScreen(url: data.toString(),),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },



    );
  }
}
