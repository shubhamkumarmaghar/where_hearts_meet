import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:where_hearts_meet/dashboard_module/service/dashboard_service.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import '../../create_event/model/event_response_model.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/week_model.dart';


class DashboardController extends BaseController {
  List<WeekModel> currentWeekDates = [];
  final service = DashboardService();
  List<EventResponseModel> eventListCreatedByUser = [];
  List<EventResponseModel> eventListCreatedForUser = [];
  String userName = '';
  String userPhone = '';
  String userImage = '';

  @override
  void onInit() {
    super.onInit();
    getDatesForWeek();
    getEventsCreatedByUser();
    getEventsCreatedForUser();
    final storage = GetStorage();
    userPhone = storage.read(userMobile) ?? '';
    userImage = storage.read(profileUrl) ?? '';
    userName = storage.read(fullName) ?? '';
    log('mobile ${storage.read(userMobile)}');
  }

  bool isCurrentDay({required String currentDay}) {
    DateTime dateTime = DateTime.now();
    final day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day.toString();
    return day == currentDay;
  }

  // void showLogoutAlertDialog({String? message, required BuildContext context, required Function logOutFunction}) {
  //   AlertDialog alert = AlertDialog(
  //       content: SizedBox(
  //     height: _mainHeight * 0.14,
  //     child: Column(
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             showImagePickerDialog(
  //               context: Get.context!,
  //               onCamera: () => onCaptureMediaClick(source: ImageSource.camera),
  //               onGallery: () => onCaptureMediaClick(source: ImageSource.gallery),
  //             );
  //           },
  //           child: Container(
  //             height: _mainHeight * 0.06,
  //             width: _mainWidth * 0.65,
  //             alignment: Alignment.center,
  //             decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: blackColor),
  //             child: const Text(
  //               'Update Image',
  //               style: TextStyle(color: whiteColor, fontSize: 16),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: _mainHeight * 0.02,
  //         ),
  //         InkWell(
  //           onTap: () {
  //             onDeleteMediaClick();
  //           },
  //           child: Container(
  //             height: _mainHeight * 0.06,
  //             width: _mainWidth * 0.65,
  //             alignment: Alignment.center,
  //             decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: blackColor),
  //             child: const Text(
  //               'Delete Image',
  //               style: TextStyle(color: whiteColor, fontSize: 16),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   ));
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

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
      cancelDialog();
      update();
    }
  }

  Future<void> getEventsCreatedByUser() async {
    setBusy(true);
    final res = await service.getAllEventsCreatedByUserApi();
    cancelDialog();
    if (res.isNotEmpty) {
      eventListCreatedByUser = res;
      update();
    }
    setBusy(false);
  }

  Future<void> getEventsCreatedForUser() async {
    setBusy(true);
    final res = await service.getAllEventsCreatedForUserApi();
    cancelDialog();
    if (res.isNotEmpty) {
      eventListCreatedForUser = res;
      update();
    }
    setBusy(false);
  }

  void getDatesForWeek() {
    final DateTime dateTime = DateTime.now();

    int dayOfYear = int.parse(DateFormat("D").format(dateTime));
    int weekNumber = ((dayOfYear - dateTime.weekday + 10) / 7).floor();

    final DateTime firstDayOfYear = DateTime.utc(dateTime.year, 1, 1);
    final int firstDayOfWeek = firstDayOfYear.weekday;
    final int daysToFirstWeek = (8 - firstDayOfWeek) % 7;

    final DateTime firstDayOfGivenWeek = firstDayOfYear.add(Duration(days: daysToFirstWeek + (weekNumber - 1) * 7));
    List<WeekModel> weekList = [];
    weekList.add(WeekModel(
        date: firstDayOfGivenWeek.day < 10
            ? '0${firstDayOfGivenWeek.day.toString()}'
            : firstDayOfGivenWeek.day.toString(),
        day: DateFormat('EEEE').format(firstDayOfGivenWeek)));

    for (int i = 1; i < 7; i++) {
      final DateTime date = firstDayOfGivenWeek.add(Duration(days: i));
      weekList.add(WeekModel(
          date: date.day < 10 ? '0${date.day.toString()}' : date.day.toString(), day: DateFormat('EEEE').format(date)));
    }

    currentWeekDates = weekList;
  }
}
