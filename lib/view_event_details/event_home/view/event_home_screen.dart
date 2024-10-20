
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/consts/string_consts.dart';
import 'package:heart_e_homies/view_event_details/event_home/controller/event_home_controller.dart';
import 'package:lottie/lottie.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/color_const.dart';
import '../../../utils/consts/confetti_shape_enum.dart';
import '../../../utils/util_functions/decoration_functions.dart';
import '../../../utils/widgets/cached_image.dart';
import '../../../utils/widgets/confetti_view.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({super.key});

  @override
  State<EventHomeScreen> createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> with TickerProviderStateMixin {
  final controller = Get.find<EventHomeController>();

  // late AnimationController descriptionAnimatedController;

  @override
  void initState() {
    super.initState();
    // descriptionAnimatedController = AnimationController(
    //   duration: const Duration(milliseconds: 500),
    //   vsync: this,
    // );
  }

  @override
  void dispose() {
    //descriptionAnimatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: controller.canShowWishes.value == false,
        onPopInvoked: (didPop) {
          controller.canShowWishes.value = !controller.canShowWishes.value;
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            toolbarHeight: 0.0,
            backgroundColor: Colors.transparent,
          ),
          floatingActionButton: Row(
            children: [
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Text(
                'Hey ${controller.eventDetails.receiverName ?? ''}',
                style: textStyleDancingScript(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              IconButton(
                //iconSize: 100,
                icon: Lottie.network(
                    height: 70, width: 70, 'https://lottie.host/1b6d706a-c23b-418b-b200-c6c0fa0f77dd/Fcls9Pt6Vo.json'),
                onPressed: () {
                  // controller.descriptionVisible.value = controller.descriptionVisible.value ? false : true;
                  // if (descriptionAnimatedController.isCompleted) {
                  //   descriptionAnimatedController.reverse(); // Animates back to the menu icon
                  // } else {
                  //   descriptionAnimatedController.forward(); // Animates to the close icon
                  // }
                  controller.canShowWishes.value = !controller.canShowWishes.value;
                },
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(controller.eventDetails.splashBackgroundImage ?? ''), fit: BoxFit.fitHeight),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Column(
                  children: [
                    ConfettiView(
                        controller: controller.homeConfettiController, confettiShapeEnum: ConfettiShapeEnum.drawHeart),
                    const Spacer(),
                    Obx(() {
                      return controller.descriptionVisible.value
                          ? Container(
                              width: screenWidth,
                              constraints: const BoxConstraints(minHeight: 0, maxHeight: 250),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                gradient:
                                    LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                  darkGreyColor,
                                  darkGreyColor.withOpacity(0.8),
                                  darkGreyColor.withOpacity(0.6),
                                  darkGreyColor.withOpacity(0.4),
                                  darkGreyColor.withOpacity(0.2),
                                ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Scrollbar(
                                thickness: 2,
                                radius: const Radius.circular(10),
                                child: SingleChildScrollView(
                                  child: Obx(() {
                                    return Text(
                                      controller.infoText.value,
                                      style: textStyleAleo(fontSize: 14),
                                    );
                                  }),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    _decorationsView(
                      title: 'Wishes',
                      subTitle: 'See all the wishes',
                      onTap: () {
                        Get.toNamed(
                          RoutesConst.wishesScreen,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _decorationsView(
                      title: 'Personal Wishes',
                      subTitle: 'See all the personal wishes',
                      onTap: () {
                        Get.toNamed(RoutesConst.personalWishesCoverScreen);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    controller.canUpdateGifts.value
                        ? _decorationsView(
                            title: 'Gifts',
                            subTitle: 'See all the gifts',
                            onTap: () {
                              Get.toNamed(RoutesConst.eGiftsScreen);
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Positioned(
                  top: screenHeight * 0.4,
                  child: Obx(
                    () {
                      return Visibility(visible: controller.canShowWishes.value, child: _wishesCardView());
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _decorationsView({required String title, required String subTitle, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 70,
        width: screenWidth,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),

          gradient: LinearGradient(colors: [
            primaryColor,
            primaryColor.withOpacity(0.8),
            primaryColor.withOpacity(0.6),
            primaryColor.withOpacity(0.4),
            primaryColor.withOpacity(0.2)
          ]),
          //color: darkGreyColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyleBasic(color: Colors.white, fontSize: 16),
                ),
                Text(
                  subTitle,
                  style: textStyleAbhayaLibre(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _wishesCardView() {
    if (controller.wishesList == null || controller.wishesList!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: 240, minHeight: 80),
      width: Get.width * 0.9,
      child: CardSwiper(
          isLoop: true,
          scale: 0.9,
          numberOfCardsDisplayed: controller.wishesList!.length > 5 ? 5 : controller.wishesList!.length,
          backCardOffset: const Offset(
            0,
            -50,
          ),
          cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage, int verticalOffsetPercentage) {
            var data = controller.wishesList![index];

            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  RoutesConst.wishesScreen,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: primaryColor, width: 1)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: cachedImage(imageUrl: data.senderProfileImage ?? ''),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (data.senderName ?? '').capitalizeFirst.toString(),
                          style: textStyleAbhayaLibre(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      StringConsts.dummyText + StringConsts.dummyText, //data.senderMessage ?? "",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleAbhayaLibre(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'View full wish',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyleAbhayaLibre(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          cardsCount: controller.wishesList?.length ?? 0),
    );
  }
}
