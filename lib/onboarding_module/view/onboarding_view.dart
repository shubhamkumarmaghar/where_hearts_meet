import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/routes/routes_const.dart';
import '../../utils/widgets/gradient_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  RxInt dotIndicator = 0.obs;
  RxBool visible = true.obs;
  final CardSwiperController controller = CardSwiperController();
  List<OnboardingModel> onboarding = [
    OnboardingModel(
      text: 'Your Ultimate Gift Guide',
      img: intro5,
      url:
          'https://i.pinimg.com/originals/71/6e/fc/716efc545dbb2b0e2a018bed028b26f7.jpg',
    ),
    OnboardingModel(
        text: 'Create Memorable Moments',
        img: intro4,
        url:
            'https://i0.wp.com/shaadiwish.com/blog/wp-content/uploads/2021/12/roka-couple-pictures-810x1024.jpeg'),
    OnboardingModel(
        text: 'Surprise & Delight',
        img: intro3,
        url:
            'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/02c28eda-4c2b-4051-8177-c24a3338489c/dg1y18w-7790bafd-abf1-4826-a474-287710a923ad.png/v1/fit/w_512,h_512,q_70,strp/love_couple_in_violet_dress_by_ecstasyai_dg1y18w-375w-2x.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTEyIiwicGF0aCI6IlwvZlwvMDJjMjhlZGEtNGMyYi00MDUxLTgxNzctYzI0YTMzMzg0ODljXC9kZzF5MTh3LTc3OTBiYWZkLWFiZjEtNDgyNi1hNDc0LTI4NzcxMGE5MjNhZC5wbmciLCJ3aWR0aCI6Ijw9NTEyIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.0dZ873Dpdn11oFEcCNsF6N_YM0ztohApNH3ghtp63TI'),
    OnboardingModel(
      text: 'Easy Fun & Personal',
      img: intro2,
      url:
          'https://i.pinimg.com/originals/71/6e/fc/716efc545dbb2b0e2a018bed028b26f7.jpg',
    ),
    OnboardingModel(
        text: 'Gift Inspiration just a click away',
        img: intro1,
        url:
            'https://i0.wp.com/shaadiwish.com/blog/wp-content/uploads/2021/12/roka-couple-pictures-810x1024.jpeg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () =>
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff9467ff),
                      Color(0xffae8bff),
                      Color(0xffc7afff),
                      Color(0xffdfd2ff),
                      Color(0xfff2edff),
                    ]),
              ),
              child: Column(children: [
                //   SizedBox(height: Get.height*0.075),
                Container(
                  height: Get.height * 0.75,
                  width: Get.width,
                  child: PageView.builder(

                    itemCount: onboarding.length,
                    itemBuilder: (BuildContext context, index) {
                      return customOnbordingText(onboarding[index].text,
                          onboarding[index].url, onboarding[index].img, index);
                    },
                    onPageChanged: (value) {
                      dotIndicator.value = value;
                    },
                  ),
                ),
                DotsIndicator(
                  dotsCount: onboarding.length,
                  position: dotIndicator.value,
                ),
                SizedBox(height: Get.height * 0.05),
                GradientButton(
                  title: 'I am Guest',
                  width: Get.width * 0.8,
                  onPressed: (){
                   // Get.offAll(const GuestDashboard());
                    Get.toNamed(RoutesConst.guestLogin);
                  },
                ),
                SizedBox(height: Get.height * 0.02),
                GradientButton(
                  title: 'Host',
                  width: Get.width * 0.8,
                  buttonColor: appColor3,
                  titleTextStyle: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 19),
                  onPressed: () {
                    Get.toNamed(RoutesConst.loginScreen);
                  },
                )
              ]),
            )
      ),
    );
  }

  customOnbordingText(String text, String url, String img, int index) {
    return Stack(
      children: [
        Animate(
        effects: [FadeEffect(), ScaleEffect()],
          child: Column(
            children: [
              index ==1?
              Container(
                height: Get.height * 0.6,
                width: Get.width,
                child: CardSwiper(controller: controller,
                    onSwipe: _onSwipe,
                    onUndo: _onUndo,
                    numberOfCardsDisplayed: 3,
                    backCardOffset: const Offset(40, 40),
                    padding: const EdgeInsets.all(24.0),cardBuilder: (
                    BuildContext context, int index, int horizontalOffsetPercentage,
                    int verticalOffsetPercentage) {
                  return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),child: Image.network(onboarding[index].url,fit: BoxFit.fill,),
                  );
                  },
                  cardsCount: onboarding.length,

                ),
              ):
              Container(
                  height: Get.height * 0.6,
                  width: Get.width,
                  child: img == ''
                      ? Image.network(fit: BoxFit.fill, url)
                      : Image.asset(img, fit: BoxFit.fill)),
              SizedBox(height: Get.height * 0.05),
              Text(
                text,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        // index ==0 ?  Positioned(
        //       child:Hero(
        //           tag: 'one',
        //           child: Center(
        //         child: Image.asset(logo,
        //             height: 200,
        //             width: 200,),
        //       )),
        // ):
        //  Positioned(
        //     left: Get.width*0.25,
        //       bottom: 30,
        //       child:Hero(tag: 'one',
        //           child: Image.asset(logo,
        //         height: 200,
        //         width: 200,)),
        // )
      ],
    );
  }
}
bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
    ) {
  debugPrint(
    'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
  );
  return true;
}

bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
    ) {
  debugPrint(
    'The card $currentIndex was undod from the ${direction.name}',
  );
  return true;
}
class CustomClipPath extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();
    // path.lineTo(0, h);

    return path;
  }
}

class OnboardingModel {
  String url;
  String text;
  String img;

  OnboardingModel({required this.url, required this.text, this.img = ''});
}
