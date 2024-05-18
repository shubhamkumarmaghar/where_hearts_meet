import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event_module/model/gift_card_model.dart';
import 'package:where_hearts_meet/utils/consts/event_special_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/dialogs/select_data_dialog.dart';
import '../../utils/repository/gift_cards_data.dart';

class AddEventSpecialsController extends BaseController {
  String eventName = '';
  int pageIndex = EventSpecialPageIndex.addWishes;
  final String _image = 'https://www.oyorooms.com/blog/wp-content/uploads/2018/02/event.jpg';

  ///wishes data
  List<String> wishesImagesList = [];
  List<String> wishesVideosList = [];

  ///timeline data
  List<String> timelineImagesList = [];
  List<String> timelineVideosList = [];

  ///secret wishes data
  List<String> secretWishesImagesList = [];
  List<String> secretWishesVideosList = [];
  final secretWishesMessageController = TextEditingController();

  ///gift card data
  final giftCardNameController = TextEditingController();
  final giftCardIdController = TextEditingController();
  final giftCardPinController = TextEditingController();
  final giftCardMessageController = TextEditingController();
  int? giftId;
  List<String>? giftCardsImages;

  @override
  void onInit() {
    super.onInit();
    eventName = Get.arguments as String;
  }

  void onNextScreen(int pageIndex) {
    this.pageIndex = pageIndex;
    update();
  }

  void onPreviousScreen(int pageIndex) {
    this.pageIndex = pageIndex;
    update();
  }

  void selectGiftCard() async {
    final card = await selectDataDialog(
        context: Get.context!, title: 'Select GiftCard', dataList: getGiftCardsDataList(), height: screenHeight * 0.32);
    if (card != null) {
      giftCardNameController.text = card.title;
      giftId = card.id;
      update();
    }
  }

  void onCaptureImage({required ImageSource source, required int pageIndex}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    final imageFile = File(image?.path ?? '');

    if (image != null) {
      uploadImage(imageFile: imageFile, pageIndex: pageIndex);
    }
  }

  Future<void> uploadImage({required File imageFile, required int pageIndex}) async {
    if (pageIndex == EventSpecialPageIndex.addWishes) {
      wishesImagesList.add(_image);
    } else if (pageIndex == EventSpecialPageIndex.addTimeline) {
      timelineImagesList.add(_image);
    } else if (pageIndex == EventSpecialPageIndex.addSecretWishes) {
      secretWishesImagesList.add(_image);
    }
    update();
  }

  void onCaptureVideo({required ImageSource source, required int pageIndex}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    final imageFile = File(image?.path ?? '');

    if (image != null) {
      uploadVideo(imageFile: imageFile, pageIndex: pageIndex);
    }
  }

  Future<void> uploadVideo({required File imageFile, required int pageIndex}) async {
    if (pageIndex == EventSpecialPageIndex.addWishes) {
      wishesVideosList.add(_image);
    } else if (pageIndex == EventSpecialPageIndex.addTimeline) {
      timelineVideosList.add(_image);
    } else if (pageIndex == EventSpecialPageIndex.addSecretWishes) {
      secretWishesVideosList.add(_image);
    }
    update();
  }
}
