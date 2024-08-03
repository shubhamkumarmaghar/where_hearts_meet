import 'dart:async';
import 'dart:developer';

import 'package:confetti/confetti.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/main.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import '../../../../show_event_module/model/event_details_model.dart';
import '../../../../utils/controller/base_controller.dart';
import '../../../create_event/model/wishes_model.dart';
import '../../../utils/consts/shared_pref_const.dart';
import '../../model/timeline_model.dart';
import '../service/guest_receive_event.dart';

class GuestHomeController extends BaseController {
  double volume = 100;
  bool muted = false;
  bool isPlayerReady = false;

  String videoUrl = 'https://hehbucket.s3.ap-south-1.amazonaws.com/112233344412.mp4';

   DateTime birthday = DateTime.now() ; // Set your birthday date here
  Duration countdownDuration = Duration();
  Timer? countdownTimer;
  GuestReceiveService guestReceiveService = GuestReceiveService();
  late ConfettiController homeConfettiController;
  EventDetailsModel? eventDetails;
  List<WishesModel> guestwishesModel = [];
  Rx<TimeLineModel> timeLineModel = TimeLineModel().obs;
  RxBool isLoading = true.obs;
  RxString infoText = RxString('');
  String mobileNo = '';
  String textTitle = '';
  String nameText = '';


  @override
  void onInit() {
    super.onInit();
    mobileNo = GetStorage().read(userMobile);
    homeConfettiController = ConfettiController(duration: const Duration(minutes: 1));
    homeConfettiController.play();
    final arg = Get.arguments;
    final parameters = Get.parameters;
    if (arg != null) {
    getData(args: arg,data: parameters);
    }


  }
  Future<void> getData({String? args, Map? data}) async {
    String byYou = data?['type'];
    await getEventDetails(eventId: args??"",byYou:byYou=='For You'?false:true );
    await textAnimation();
     getEventWishes(args??"");
     getTimelineWishes(args??"");
    startCountdown();
    update();
  }

  Future<void> textAnimation() async {
    String? text = eventDetails?.eventName;
    List<String>? wordsList = text?.split('');
    for (var word in wordsList!) {
      await Future.delayed(const Duration(milliseconds: 200));
        textTitle = textTitle + word;
    update();
    }
    nameAnimation();
  }

  void nameAnimation() async {
    String? name = eventDetails?.receiverName;
    List<String>? wordsList = name?.split('');
    for (var word in wordsList!) {
      await Future.delayed(Duration(milliseconds: 200));
        nameText = nameText + word;
    update();
    }
  }

  Future<void> getEventDetails({required String eventId ,bool byYou = true}) async {

    setBusy(true);
    eventDetails = await guestReceiveService.getEventDetails(eventId: eventId, mobileNo: mobileNo,type: byYou);
    birthday = DateTime.parse(eventDetails?.eventHostDay ?? DateTime.now().toString());
    setBusy(false);
    showDescription();
    update();
  }


  Future<void> getEventWishes(String eventId) async {
   // setBusy(true);
    var res = await guestReceiveService.getWishesList(eventId: eventId);
    guestwishesModel = res;
    log('Data ${guestwishesModel.length}');
   // setBusy(false);
    update();
  }

  Future<void> getTimelineWishes(String eventId) async {
    showLoaderDialog(context: Get.context!);
   // setBusy(true);
    timeLineModel.value = await guestReceiveService.getTimeline(eventId: eventId);
    cancelDialog();
    log('zzzz ${timeLineModel.value.toJson()}');
   // setBusy(false);
    update();
  }

  void showDescription() async {
    final info = eventDetails?.eventDescription ?? '';
    final List<String> list = info.split('');
    String showInfo = '';
    for (var data in list) {
      showInfo = '$showInfo$data';
      await Future.delayed(const Duration(milliseconds: 60));
      infoText.value = showInfo;
    }
  }

  Future<void> startCountdown() async {
    if(birthday.isAfter(DateTime.now())){

    countdownDuration =birthday.difference(DateTime.now());
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      countdownDuration = birthday.difference(DateTime.now());

    });}
    else{

      countdownDuration = birthday.difference(birthday);

    }
     // countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
       // countdownDuration = birthday.difference(birthday);
    update();
  }

  @override
  void onClose() {
    homeConfettiController.dispose();
    super.onClose();
  }
}
