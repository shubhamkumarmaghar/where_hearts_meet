import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/dropdown_model.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../model/event_response_model.dart';
import '../model/personal_messages_model.dart';
import '../service/create_event_service.dart';

class CreatePersonalMessagesController extends BaseController {
  late EventResponseModel eventResponseModel;
  ImageResponseModel? backgroundImage;
  final createEventService = CreateEventService();
  final messageTextController = TextEditingController();
  List<DropDownModel> messagesList = [];
  Rx<Color> textColor = Colors.black.obs;
  ScrollController scrollController = ScrollController();
  RxBool submitButtonEnabled = false.obs;
  FocusNode focusNode = FocusNode();
  RxBool isEditingMessage = false.obs;
  RxInt currentEditingIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    eventResponseModel = createdEvent.getCurrentEvent ?? EventResponseModel();
  }

  void saveMessage() {
    if (messageTextController.text.trim().isEmpty) {
      return;
    }
    if (isEditingMessage.value) {
      messagesList[currentEditingIndex.value] = DropDownModel(title: messageTextController.text);
      isEditingMessage.value = false;
      messageTextController.clear();
      focusNode.unfocus();
      update();
    } else {
      messagesList.add(DropDownModel(title: messageTextController.text));
      messageTextController.clear();
      _animateToLast();
      updateSubmitButtonStatus();
      update();
    }
  }

  void _deleteMessage(int index) {
    messagesList.removeAt(index);
    _animateToLast();
    updateSubmitButtonStatus();
    update();
  }

  void _editMessage(int index) {
    final message = messagesList[index];
    messageTextController.text = message.title;
    focusNode.requestFocus(FocusNode());
    isEditingMessage.value = true;
    currentEditingIndex.value = index;

    update();
  }

  void onLongPress(int index) async {
    final action = await showMessageActionDialog(Get.context!);
    if (action != null) {
      if (action == AppActions.delete) {
        _deleteMessage(index);
      } else if (action == AppActions.edit) {
        _editMessage(index);
      }
    }
    update();
  }

  void updateSubmitButtonStatus() {
    if (messagesList.isNotEmpty) {
      submitButtonEnabled.value = true;
    } else {
      submitButtonEnabled = false.obs;
    }
  }

  void _animateToLast() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        (scrollController.position.maxScrollExtent + (screenHeight * 0.2)),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  void _updateBackgroundImage() {
    showImagePickerDialog(
      context: Get.context!,
      title: StringConsts.uploadImage,
      onCamera: () => _onCaptureImage(source: ImageSource.camera),
      onGallery: () => _onCaptureImage(source: ImageSource.gallery),
    );
  }

  void showMessageOptions() async {
    final action = await showButtonDialog(
        context: Get.context!,
        dataList: [
          DropDownModel(id: 1, title: StringConsts.changeBackgroundImage),
          DropDownModel(id: 2, title: StringConsts.changeTextColor),
        ],
        height: screenHeight * 0.2);
    if (action != null) {
      if (action.id == 1) {
        _updateBackgroundImage();
      } else if (action.id == 2) {
        _updateTextColor();
      }
    }
  }

  void _updateTextColor() async {
    final color = await showColorPickerDialog(context: Get.context!, selectedColor: textColor.value);
    if (color != null) {
      textColor.value = color;
    }
  }

  void _onCaptureImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, maxHeight: 800, maxWidth: 800, imageQuality: 80);

    if (image != null) {
      final croppedImage = await cropImage(
        filePath: image.path,
      );
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          backgroundImage = imageResponse;
          update();
        }
      }
    }
  }

  void submitPersonalMessages() async {
    if (submitButtonEnabled.value) {
      showLoaderDialog(context: Get.context!);
      final model = PersonalMessagesModel(
          eventId: eventResponseModel.eventid,
          messages: messagesList.map((e) => e.title).toList(),
          image: backgroundImage?.fileId,
          textColor: textColor.value.value.toString());
      final response = await createEventService.addPersonalMessagesApi(model: model);
      cancelDialog();
      if (response != null) {
        navigateToPersonalDecorationsScreen();
      }
    }
  }

  void navigateToPersonalDecorationsScreen() {
    Get.toNamed(RoutesConst.createPersonalDecorationsScreen);
  }

  @override
  void onClose() {
    messageTextController.dispose();
    scrollController.dispose();
    textColor.close();
    isEditingMessage.close();
    currentEditingIndex.close();
    focusNode.dispose();
    super.onClose();
  }
}
