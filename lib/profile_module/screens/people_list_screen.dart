import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/profile_module/controller/people_list_controller.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';

class PeopleListScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<PeopleListController>();

  PeopleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('People')),
      body: BaseContainer(
        child: GetBuilder<PeopleListController>(
          builder: (controller) {
            return Container(
              height: _mainHeight,
              width: _mainWidth,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                mainAxisAlignment: controller.isBusy ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  controller.isBusy
                      ? CircularProgressIndicator()
                      : Container(
                          height: _mainHeight * 0.75,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var data = controller.peopleList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: greyColor.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(data.name ?? '',
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: _mainHeight * 0.005,
                                          ),
                                          Text(data.email ?? '',
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      const Spacer(),
                                       InkWell(
                                        onTap: ()async{
                                          await controller.deletePeople(uid: data.uid ?? '');

                                        },
                                        child: const CircleAvatar(
                                            backgroundColor: redColorDefault,
                                            child: Icon(Icons.delete,color: whiteColor,)),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                    height: 5,
                                  ),
                              itemCount: controller.peopleList.length),
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
