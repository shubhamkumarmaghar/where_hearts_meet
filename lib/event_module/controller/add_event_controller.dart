
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/event_module/model/add_event_model.dart';
import 'package:where_hearts_meet/profile_module/controller/add_people_controller.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/model/event_type_model.dart';
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
  final eventTypeController = TextEditingController();
  final subtitleController = TextEditingController();
  final firebaseStorageController = Get.find<FirebaseStorageController>();
  final infoController = TextEditingController();
  String imageUrl1 = '';
  String imageUrl2 = '';
  String imageUrl3 = '';
  String imageUrl4 = '';
  String imageUrl5 = '';
  String imageUrl6 = '';
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  ScreenName? screenType;
  List<PeopleModel> allUsersList = [];
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  PeopleModel selectedUser = PeopleModel();
  bool userSelected = false;
  EventTypeModel selectedEventType = EventTypeModel(eventName: 'Select Event',eventTypeId: '0',eventIcon: Icons.select_all);

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

  void onCaptureMediaClick({required ImageSource source, required int number}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    final imageFile = File(image?.path ?? '');

    if (image != null) {
      showLoaderDialog(context: Get.context!);
      final url = await firebaseStorageController.uploadEventPic(file: imageFile, eventName: '${image.name}_${eventNameController.text}');
      if (number == 1) {
        imageUrl1 = url;
      }
      if (number == 2) {
        imageUrl2 = url;
      }
      if (number == 3) {
        imageUrl3 = url;
      }
      if (number == 4) {
        imageUrl4 = url;
      }
      if (number == 5) {
        imageUrl5 = url;
      }
      if (number == 6) {
        imageUrl6 = url;
      }

      cancelLoaderDialog();
      update();
    }
  }

  Future<void> addEvent() async {
     if (nameController.text.isEmpty) {
      showSnackBar(context: Get.context!, message: 'Please enter name');
      return;
    } else if (eventNameController.text.isEmpty) {
      showSnackBar(context: Get.context!, message: 'Please enter event name');
      return;
    } else if (infoController.text.isEmpty) {
      showSnackBar(context: Get.context!, message: 'Please enter info');
      return;
    } else if (selectedEventType.eventTypeId == '0') {
      showSnackBar(context: Get.context!, message: 'Please select event type');
      return;
    } else if (screenType == ScreenName.fromDashboard && (selectedUser.email == null || selectedUser.email == "")) {
       showSnackBar(context: Get.context!, message: 'Please Select User');
       return;
     }else if (imageUrl1 == '' || imageUrl2 == ''|| imageUrl3 == ''|| imageUrl4 == ''|| imageUrl5 == ''|| imageUrl6 == '') {
      showSnackBar(context: Get.context!, message: 'Please upload image');
      return;
    }

    showLoaderDialog(context: Get.context!);
    var email;
    if (screenType == ScreenName.fromAddPeople) {
      final peopleController = Get.find<AddPeopleController>();
      email = peopleController.selectedUser.email;
    } else if (screenType == ScreenName.fromDashboard) {
      email = selectedUser.email;
    }

    await fireStoreController.addEvent(
        addEventModel: AddEventModel(
            imageUrl: imageUrl1,
            imageList: [imageUrl1,imageUrl2,imageUrl3,imageUrl4,imageUrl5,imageUrl6],
            personName: nameController.text,
            eventName: eventNameController.text,
            eventType: eventTypeController.text,
            title: titleController.text,
            subtitle: subtitleController.text,
            eventInfo: infoController.text,
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
                        child: const Icon(
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
                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                    child: data.imageUrl != null && data.imageUrl != ''
                                        ? Image.network(
                                            data.imageUrl ?? '',
                                            fit: BoxFit.fill,
                                          )
                                        : const Icon(Icons.person),
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

  void selectEventSheet()async{
    final event = await _showEventsTypeBottomSheet();
    if(event != null){
      selectedEventType = event;
      eventTypeController.text=selectedEventType.eventName ??'Others';
      update();
    }
  }

  Future<EventTypeModel?> _showEventsTypeBottomSheet() {
    return showModalBottomSheet<EventTypeModel>(
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
            height: Get.height * 0.7,
            padding:  EdgeInsets.only(top: _mainHeight*0.02),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Select Event Type',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: _mainHeight*0.02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: _mainHeight*0.62,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = getEventsTypeList()[index];
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).pop(data);
                          },
                          child: SizedBox(
                            height: _mainHeight*0.04,
                            child: Row(
                              children: [
                                Icon(data.eventIcon,color: primaryColor,),
                                SizedBox(width: _mainWidth*0.03,),
                                Text(data.eventName ??'',style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor
                                ),)
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: getEventsTypeList().length),
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
    eventTypeController.dispose();
    super.dispose();
  }
}
