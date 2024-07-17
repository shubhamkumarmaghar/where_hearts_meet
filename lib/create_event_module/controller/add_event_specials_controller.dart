import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/show_event_module/model/event_details_model.dart';
import 'package:where_hearts_meet/utils/consts/event_special_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/dialogs/select_data_dialog.dart';
import '../../utils/repository/gift_cards_data.dart';
import '../../utils/services/functions_service.dart';
import '../service/create_event_service.dart';
import 'package:http_parser/http_parser.dart';

class AddEventSpecialsController extends BaseController {
  late EventDetailsModel eventDetailsModel;
  int pageIndex = EventSpecialPageIndex.addWishes;
  final EventApiService _eventApiService = EventApiService();
  final String _image = 'https://www.oyorooms.com/blog/wp-content/uploads/2018/02/event.jpg';

  ///wishes data
  List<File> wishesImagesList = [];
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
    eventDetailsModel = Get.arguments as EventDetailsModel;
    log('while navigate ${eventDetailsModel.toJson()}');
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
      wishesImagesList.add(imageFile);
    } else if (pageIndex == EventSpecialPageIndex.addTimeline) {
      timelineImagesList.add(_image);
    } else if (pageIndex == EventSpecialPageIndex.addSecretWishes) {
      secretWishesImagesList.add(_image);
    }
    update();
  }

  void onCaptureVideo({required ImageSource source, required int pageIndex}) async {
    final ImagePicker picker = ImagePicker();

    var video = await picker.pickVideo(
      source: source,
    );
    final videoFile = File(video?.path ?? '');

    if (video != null) {
      uploadVideo(videoFile: videoFile, pageIndex: pageIndex);
    }
  }

  Future<void> uploadVideo({required File videoFile, required int pageIndex}) async {
    showLoaderDialog(context: Get.context!);

    var path = videoFile.path.split('/');
    final url = await FunctionsService.uploadFileToAWS(
        file: videoFile);

    cancelDialog();
    if (pageIndex == EventSpecialPageIndex.addWishes) {
      wishesVideosList.add(url);
    } else if (pageIndex == EventSpecialPageIndex.addTimeline) {
      timelineVideosList.add(url);
    } else if (pageIndex == EventSpecialPageIndex.addSecretWishes) {
      secretWishesVideosList.add(url);
    }
    update();
  }

  String getAwsEventKey({required int pageIndex, required String eventId, required String fileName}) {
    if (pageIndex == EventSpecialPageIndex.addWishes) {
      return 'events/$eventId/wishes/$fileName';
    } else if (pageIndex == EventSpecialPageIndex.addTimeline) {
      return 'events/$eventId/timeline/$fileName';
    } else if (pageIndex == EventSpecialPageIndex.addSecretWishes) {
      return 'events/$eventId/secret_wishes/$fileName';
    } else {
      return 'events/$eventId/any/$fileName';
    }
  }

  Future<void> submitWishes() async {
    showLoaderDialog(context: Get.context!);
    List<dio.MultipartFile> imageFiles = [];
    for (var image in wishesImagesList) {
      final img = await dio.MultipartFile.fromFile(image.path ?? '',
          filename: (image.path.split('/')).last, contentType: MediaType('image', (image.path.split('.')).last));
      imageFiles.add(img);
    }

    final response = await _eventApiService.submitEventWishes(
        eventId: eventDetailsModel.eventid ?? '', imageFiles: imageFiles, videoFiles: wishesVideosList);

    cancelDialog();
  }
}
