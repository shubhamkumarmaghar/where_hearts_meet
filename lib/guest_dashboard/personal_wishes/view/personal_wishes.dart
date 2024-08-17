import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/text_styles/custom_text_styles.dart';
import '../../guest_home/controller/guest_home_controller.dart';
import '../controller/PersonalWishesController.dart';

class GetPersonalWishScreen extends StatefulWidget {
  const GetPersonalWishScreen({super.key});

  @override
  State<GetPersonalWishScreen> createState() => _GetPersonalWishScreenState();
}

class _GetPersonalWishScreenState extends State<GetPersonalWishScreen> {

List<String> data = [
  'I want to wish you with all my heart',
  'I want to wish you with all my heart shubham ',
  'I want to wish you with all my heart goku ',
  'I want to wish you with all my heart deepK ',
];
int indexNo=0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalWishesController>(
      init:PersonalWishesController() ,
      builder: (controller){
        return  Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  heightSpace(screenHeight * 0.08),
                  const CircleAvatar(backgroundImage: AssetImage(su1), radius: 40),
                  heightSpace(screenHeight * 0.01),
                  getPrimaryText(text: 'Shubham Kumar', fontSize: 20),
                  getPrimaryText(text: '15/09/1997'),
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
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: getPrimaryText(
                              text: 'Memories', textColor: Colors.grey),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: getPrimaryText(
                              text: 'Memories', textColor: Colors.grey),
                        ),
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
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(25),
                          )),
                      child: ListView(
                          children: [
                            heightSpace(screenHeight*0.02),
                            getPrimaryText(text: data[indexNo],
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
                          log('  ${data[indexNo]}  $index');
                        });
                      },


                    ),
                    items: controller.homeController.timeLineModel.value.images?.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            // width: screenWidth*0.6,
                            //  height: Get.height*0.75,

                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
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
