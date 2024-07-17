
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

class EventCard extends StatelessWidget {
  final EventResponseModel eventResponseModel;
  final Function onCardTap;

  EventCard({Key? key, required this.eventResponseModel, required this.onCardTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onCardTap();
      },
      child: Container(
        width: screenWidth*0.85,
        padding: const EdgeInsets.only(left: 7, top: 0, bottom: 7, right: 0),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
        child: Container(
            padding: const EdgeInsets.only(left: 7, top: 7, right: 7),
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: [
                SizedBox(
                    height:screenHeight * 0.2,
                    width: screenWidth * 0.75,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.network(
                          eventResponseModel.splashBackgroundImage ?? '',
                          fit: BoxFit.fill,
                        ))),
                SizedBox(
                  height: screenHeight*0.01,
                ),
                Text(eventResponseModel.eventName ??'')
              ],
            )),
      ),
    );
  }
}
