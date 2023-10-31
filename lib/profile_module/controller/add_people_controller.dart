import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/profile_module/model/people_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/model/user_info_model.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';

import '../../utils/consts/color_const.dart';

class AddPeopleController extends BaseController {
  List<UserInfoModel> allUsersList = [];
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  UserInfoModel selectedUser = UserInfoModel();
  bool userSelected = false;

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }

  Future<void> getAllUsers() async {
    setBusy(true);
    allUsersList = await fireStoreController.getAllUsers();
    setBusy(false);
  }
  Future<void> addPeople()async{
    showLoaderDialog(context: Get.context!);
    await fireStoreController.addPeople(peopleModel: PeopleModel(
      name: selectedUser.name,
      uid: selectedUser.uid,
      email: selectedUser.email,
      imageUrl: selectedUser.imageUrl,
      dateOfBirth: selectedUser.dateOfBirth
    ));
    cancelLoaderDialog();
    Get.offAndToNamed(RoutesConst.addEventScreen);
  }

  void showUsersBottomSheet() {
    showModalBottomSheet<void>(
      context: Get.context!,
      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            height: Get.height * 0.75,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Users',
                      style: TextStyle(
                        fontSize: 20,
                        color: blackColor,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.clear,color: blackColor,size: 20,))
                  ],
                ),
                SizedBox(
                  height: _mainHeight*0.03,
                ),
                Container(
                  height: Get.height * 0.65,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = allUsersList[index];
                        return InkWell(
                          onTap: (){
                            selectedUser = data;
                            userSelected = true;
                            Navigator.of(context).pop();
                            update();

                          },
                          child: Container(
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
                                    child:data.imageUrl != null && data.imageUrl != ''? Image.network(
                                      data.imageUrl ?? '',
                                      fit: BoxFit.fill,
                                    ):Icon(Icons.person),
                                  ),
                                ),
                                SizedBox(
                                  width: _mainWidth * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(data.name ?? '',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: _mainHeight * 0.005,
                                    ),
                                    Text(data.email ?? '',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: allUsersList.length),
                ),
              ],
            ));
      },
    );
  }
}
