import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/event_module/controller/event_list_controller.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/widgets/base_container.dart';

class EventListScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<EventListController>();
  EventListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Events')),
      body: BaseContainer(
        child: GetBuilder<EventListController>(
          builder: (controller) {
            return Container(
              height: _mainHeight,
              width: _mainWidth,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                mainAxisAlignment: controller.isBusy?MainAxisAlignment.center:MainAxisAlignment.start,
                children: [
                  controller.isBusy
                      ? CircularProgressIndicator()
                      : Container(
                    height: _mainHeight * 0.75,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var data = controller.currentUserEventList[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: greyColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)
                            ),

                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: _mainHeight * 0.06,
                                  width: _mainWidth * 0.14,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    child: Image.network(
                                      data.imageUrl ?? '',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: _mainWidth * 0.04,
                                ),
                                Column(
                                  children: [
                                    Text(data.eventName ?? '',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: _mainHeight * 0.005,
                                    ),
                                    Text(data.text1 ?? '',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: _mainHeight * 0.005,
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text('from - ${data.fromEmail}',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: greyColor)),
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: controller.currentUserEventList.length),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
