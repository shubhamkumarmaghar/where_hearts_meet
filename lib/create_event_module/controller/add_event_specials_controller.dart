import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event_module/model/gift_card_model.dart';
import 'package:where_hearts_meet/utils/consts/event_special_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';

import '../../utils/dialogs/pop_up_dialogs.dart';

class AddEventSpecialsController extends BaseController {
  String eventName = '';
  int pageIndex = EventSpecialPageIndex.addWishes;
  final String _image = 'https://www.oyorooms.com/blog/wp-content/uploads/2018/02/event.jpg';
  List<String> imagesWishesList = [];
  List<String> videosWishesList = [];
  GiftCardModel selectedGiftCard = GiftCardModel();

  @override
  void onInit() {
    super.onInit();
    eventName = Get.arguments as String;
  }

  void updateGiftCard() {}

  void onNextScreen(int pageIndex) {
    this.pageIndex = pageIndex;
    update();
  }

  void onPreviousScreen(int pageIndex) {
    this.pageIndex = pageIndex;
    update();
  }

  void onCaptureImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    final imageFile = File(image?.path ?? '');

    if (image != null) {
      imagesWishesList.add(_image);
      // showLoaderDialog(context: Get.context!);
      // ///function call for image
      // cancelLoaderDialog();
      update();
    }
  }

  void onCaptureVideo({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    final imageFile = File(image?.path ?? '');

    if (image != null) {
      videosWishesList.add(_image);
      // showLoaderDialog(context: Get.context!);
      // ///function call for image
      // cancelLoaderDialog();
      update();
    }
  }
}
