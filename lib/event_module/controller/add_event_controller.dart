import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/event_module/model/add_event_model.dart';
import 'package:where_hearts_meet/profile_module/controller/add_people_controller.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';

import '../../profile_module/model/people_model.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/services/firebase_firestore_controller.dart';
import '../../utils/services/firebase_storage_controller.dart';

class AddEventController extends BaseController {
  final nameController = TextEditingController();
  final eventNameController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final infoController = TextEditingController();
  String imageUrl = '';
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  ScreenName? screenType;
  List<PeopleModel> allUsersList = [];
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  PeopleModel selectedUser = PeopleModel();
  bool userSelected = false;

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
    final arg = Get.arguments;
    if (arg != null) {
      screenType = arg as ScreenName;
    }
  }

  Future<void> getAllUsers() async {
    setBusy(true);
    allUsersList = await fireStoreController.getAllUsers();
    setBusy(false);
  }

  void onCaptureMediaClick({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    final imageFile = File(image?.path ?? '');

    if (image != null) {
      showLoaderDialog(context: Get.context!);
      final firebaseStorageController = Get.find<FirebaseStorageController>();
      final url = await firebaseStorageController.uploadEventPic(file: imageFile, eventName: eventNameController.text);
      imageUrl = url;
      cancelLoaderDialog();
      update();
    }
  }

  Future<void> addEvent() async {
    if (screenType == ScreenName.fromDashboard && (selectedUser.email == null || selectedUser.email == "")) {
      showSnackBar(context: Get.context!,message: 'Please Select User');
      return;
    } else if (nameController.text.isEmpty) {
      showSnackBar(context: Get.context!,message: 'Please enter name');
      return;
    } else if (eventNameController.text.isEmpty) {
      showSnackBar(context: Get.context!,message: 'Please enter event name');
      return;
    } else if (infoController.text.isEmpty) {
      showSnackBar(context: Get.context!,message: 'Please enter info');
      return;
    } else if (imageUrl == '') {
      showSnackBar(context: Get.context!,message: 'Please upload image');
      return;
    }
    showLoaderDialog(context: Get.context!);
    var email;
    if(screenType == ScreenName.fromAddPeople){
      final peopleController = Get.find<AddPeopleController>();
      email = peopleController.selectedUser.email;
    }else if(screenType == ScreenName.fromDashboard){
      email = selectedUser.email;
    }

    await fireStoreController.addEvent(
        addEventModel: AddEventModel(
            imageUrl: imageUrl,
            name: nameController.text,
            eventName: eventNameController.text,
            text1: titleController.text,
            text2: subtitleController.text,
            text3: infoController.text,
            fromEmail: firebaseAuthController.getCurrentUser()?.email,
            toEmail: email));
    cancelLoaderDialog();
    Get.offAllNamed(RoutesConst.dashboardScreen);
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
                      style: TextStyle(fontSize: 20, color: blackColor, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.clear,
                          color: blackColor,
                          size: 20,
                        ))
                  ],
                ),
                SizedBox(
                  height: _mainHeight * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.65,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = allUsersList[index];
                        return InkWell(
                          onTap: () {
                            selectedUser = data;
                            userSelected = true;
                            Navigator.of(context).pop();
                            update();
                          },
                          child: Container(
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
                                    child: data.imageUrl != null && data.imageUrl != ''
                                        ? Image.network(
                                            data.imageUrl ?? '',
                                            fit: BoxFit.fill,
                                          )
                                        : Icon(Icons.person),
                                  ),
                                ),
                                SizedBox(
                                  width: _mainWidth * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(data.name ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: _mainHeight * 0.005,
                                    ),
                                    Text(data.email ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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

  @override
  void dispose() {
    nameController.dispose();
    eventNameController.dispose();
    titleController.dispose();
    subtitleController.dispose();
    infoController.dispose();
    super.dispose();
  }
}
