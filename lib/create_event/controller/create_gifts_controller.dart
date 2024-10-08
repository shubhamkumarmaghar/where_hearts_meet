import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event/model/gift_model.dart';
import 'package:where_hearts_meet/create_event/model/gifts_data_model.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../model/event_response_model.dart';
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

  List<ImageResponseModel> imagesList = [];
  final createEventService = CreateEventService();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    eventResponseModel = createdEvent.getCurrentEvent ?? EventResponseModel();
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

  void onCaptureMediaClick({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, maxHeight: 800, maxWidth: 800, imageQuality: 100);

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
      nextButtonTitle.value = StringConsts.skip;
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
    if (createdEvent.getCurrentEvent != null) {
      createdEvent.setEvent(null);
    }
    Get.offAllNamed(RoutesConst.dashboardScreen);
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
