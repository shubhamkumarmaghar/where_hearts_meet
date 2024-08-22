import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/util_functions/decoration_functions.dart';

class CreatedGiftsPreviewScreen extends StatelessWidget {
  CreatedGiftsPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(gradient: backgroundGradient),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            appHeader,
            headerListView(),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            // giftsCardSwiper()
            giftBodyView(),
            SizedBox(
              height: screenHeight * 0.02,
            ),

            giftsCardSwiper()
          ],
        ),
      ),
    );
  }

  Widget giftBodyView() {
    return Container(
      height: 220,
      width: screenWidth,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(logo), colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.srcIn))),
      child: Container(
        padding: EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              '1221 4344 5532 4424',
              style: textStyleAbel(fontSize: 24),
            ),
            Text(
              '123456',
              style: textStyleAbel(fontSize: 24),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Given by : DkRockX',
                  style: textStyleDangrek(fontSize: 18),
                ),
                Container(
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      'Amazon',
                      style: textStyleDangrek(),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget giftsCardSwiper() {
    return Container(
      height: 300,
      width: screenWidth,
      child: CardSwiper(
        padding: EdgeInsets.zero,
        cardsCount: cards.length,
        allowedSwipeDirection: AllowedSwipeDirection.only(left: true, right: true),
        numberOfCardsDisplayed: 3,
        controller: CardSwiperController(),
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
      ),
    );
  }

  List<Container> cards = [
    Container(
      height: 120,
      child: Image.network('https://t3.ftcdn.net/jpg/01/80/48/98/360_F_180489844_fsK0P7QCfeznToYRvsLm3fN5oMGSQCBw.jpg',fit: BoxFit.cover,),
    ),
    Container(
      height: 120,
      child: Image.network('https://t3.ftcdn.net/jpg/01/80/48/98/360_F_180489844_fsK0P7QCfeznToYRvsLm3fN5oMGSQCBw.jpg',fit: BoxFit.cover),
    ),
    Container(
      height: 120,
      child: Image.network('https://t3.ftcdn.net/jpg/01/80/48/98/360_F_180489844_fsK0P7QCfeznToYRvsLm3fN5oMGSQCBw.jpg',fit: BoxFit.cover),
    ),
    Container(
      height: 120,
      child: Image.network('https://t3.ftcdn.net/jpg/01/80/48/98/360_F_180489844_fsK0P7QCfeznToYRvsLm3fN5oMGSQCBw.jpg',fit: BoxFit.cover),
    ),
  ];

  Widget headerListView() {
    return Container(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: index == 1 ? Border.all(color: Colors.yellow, width: 3) : null),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        giftsIcon,
                        fit: BoxFit.cover,
                      )),
                ),
                Text(
                  'Deepak',
                  style: textStyleDangrek(),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: 5),
    );
  }
}
