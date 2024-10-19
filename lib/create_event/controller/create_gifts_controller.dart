import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/routes_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../model/event_response_model.dart';
import '../model/gift_model.dart';
import '../model/gifts_data_model.dart';
import '../service/create_event_service.dart';

class CreateGiftsController extends BaseController {
  late EventResponseModel eventResponseModel;
  RxString nextButtonTitle = StringConsts.skip.obs;
  RxInt giftCardGroupValue = 0.obs;
  final _createEventService = CreateEventService();
  List<GiftsCard>? giftsDataList;
  List<GiftModel> submittedGiftsList = [];
  GiftsCard? selectedGift;
  final nameTextController = TextEditingController();
  final giftTitleController = TextEditingController();
  final giftCardIdController = TextEditingController();
  final giftCardPinController = TextEditingController();
  String selectGiftText = '${StringConsts.selectGift}*';
  bool canTitleChange = true;
  late bool forEdit;

  List<ImageResponseModel> imagesList = [];
  final createEventService = CreateEventService();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    eventResponseModel = createdEvent.getCurrentEvent ?? EventResponseModel();
    forEdit = createdEvent.actions == AppActions.edit || createdEvent.actions == AppActions.update;
    getGifts();
  }

  void onSelectGiftCard(int? value) {
    giftCardGroupValue.value = value ?? 0;
    if (giftsDataList != null) {
      selectedGift = giftsDataList!.firstWhere((element) => element.id == value);
    }
    update();
  }

  void onGiftTypeSelected() {
    Get.back();
  }

  void navigateToGiftPreviewScreen() {
    Get.toNamed(RoutesConst.createdGiftsPreviewScreen, arguments: submittedGiftsList);
  }

  Future<void> getGifts() async {
    setBusy(true);
    final response = await _createEventService.getGiftsApi();
    setBusy(false);
    if (response != null && response.isNotEmpty) {
      giftsDataList = response;
    }
    update();
  }

  void onPop() {
    selectedGift = null;
    giftCardGroupValue.value = -100;
    Get.back();
  }

  void uploadGiftImage() {
    showImagePickerDialog(
      context: Get.context!,
      onCamera: () => _onCaptureImage(source: ImageSource.camera),
      onGallery: () => _onCaptureImage(source: ImageSource.gallery),
    );
  }

  void deleteFile({required int index}) async {
    showLoaderDialog(context: Get.context!);

    String fileUrl = imagesList[index].fileUrl ?? '';

    final response = await createEventService.deleteFileApi(fileUrl: fileUrl);
    cancelDialog();
    if (response) {
      imagesList.removeAt(index);
      update();
    }
  }

  void _onCaptureImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, maxHeight: 800, maxWidth: 800, imageQuality: 80);

    if (image != null) {
      final croppedImage = await cropImage(filePath: image.path, isProfileImage: false);
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          imagesList.add(imageResponse);
          update();
        }
      }
    }
  }

  void addGifts() async {
    if (selectedGift == null) {
      AppWidgets.getToast(message: 'Select gift');
      return;
    }
    if (nameTextController.text.isEmpty) {
      AppWidgets.getToast(message: 'Sender name can not be empty');
      return;
    }
    if (giftTitleController.text.isEmpty) {
      AppWidgets.getToast(message: 'Gift title can not be empty');
      return;
    }

    if (giftCardIdController.text.isEmpty && giftCardPinController.text.isEmpty && imagesList.isEmpty) {
      AppWidgets.getToast(message: 'Add gift card id or add gifts images');
      return;
    }

    showLoaderDialog(context: Get.context!);
    GiftModel model = GiftModel();

    model.eventId = eventResponseModel.eventid ?? '';
    model.senderName = nameTextController.text;
    model.giftCode = selectedGift?.code ?? '';
    model.giftTitle = giftTitleController.text;
    model.cardId = giftCardIdController.text;
    model.cardPin = giftCardPinController.text;
    model.giftImages = imagesList.map((e) => e.fileId ?? '').toList();

    final response = await _createEventService.addGiftsEventApi(giftModel: model);
    cancelDialog();
    if (response != null) {
      submittedGiftsList.add(response);
      nameTextController.clear();
      selectedGift = null;
      selectGiftText = 'Select Gift*';
      giftTitleController.clear();
      giftCardIdController.clear();
      giftCardPinController.clear();
      imagesList.clear();
      nextButtonTitle.value = StringConsts.next;
      update();
    }
  }

  void navigateToGiftTypeScreen() async {
    await Get.toNamed(RoutesConst.selectGiftsScreen);
    if (selectedGift != null) {
      selectGiftText = selectedGift?.title ?? "";
      giftTitleController.text = selectedGift?.title ?? '';
      canTitleChange = selectedGift?.code == 'other' ? true : false;
      update();
    }
  }

  void navigateToEventCompletedScreen() async {
    var createdEvent = locator<CreatedEventRepo>();
    if (createdEvent.actions == AppActions.update) {
      Get.back(result: submittedGiftsList.isNotEmpty);
    } else {
      createdEvent.clearRepo();
      Get.offAllNamed(RoutesConst.dashboardScreen);
    }
  }

  @override
  void onClose() {
    nameTextController.dispose();
    giftTitleController.dispose();
    giftCardIdController.dispose();
    giftCardPinController.dispose();
    super.onClose();
  }
}
