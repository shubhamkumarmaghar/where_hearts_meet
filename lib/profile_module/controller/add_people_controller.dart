

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/profile_module/model/people_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';

import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';

import '../../dashboard_module/controller/dashboard_controller.dart';
import '../../utils/consts/color_const.dart';

class AddPeopleController extends BaseController {
  List<PeopleModel> allUsersList = [];
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final dashboardController = Get.find<DashboardController>();
  PeopleModel selectedUser = PeopleModel();
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
    final response=await fireStoreController.addPeople(peopleModel: selectedUser);
    cancelDialog();
    if(response){
      await dashboardController.getPeopleList();
      Get.back();
    }

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
                    const Text(
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
                        child: const Icon(Icons.clear,color: blackColor,size: 20,))
                  ],
                ),
                SizedBox(
                  height: _mainHeight*0.03,
                ),
                SizedBox(
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

                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: _mainHeight * 0.06,
                                  width: _mainWidth * 0.14,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                    child:data.imageUrl != null && data.imageUrl != ''? Image.network(
                                      data.imageUrl ?? '',
                                      fit: BoxFit.fill,
                                    ):const Icon(Icons.person),
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
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: _mainHeight * 0.005,
                                    ),
                                    Text(data.email ?? '',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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
