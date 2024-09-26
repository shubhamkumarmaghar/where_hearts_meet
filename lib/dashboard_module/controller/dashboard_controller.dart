import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../create_event/model/event_response_model.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/week_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../service/dashboard_service.dart';

class DashboardController extends BaseController {
  List<WeekModel> currentWeekDates = [];
  final service = DashboardService();
  List<EventResponseModel>? eventListCreatedByUser;
  List<EventResponseModel>? eventListCreatedForUser;
  String? userName;

  String? userPhone;

  String? userImage;

  @override
  void onInit() {
    super.onInit();
    getDatesForWeek();
    getEventsCreatedByUser();
    getEventsCreatedForUser();
    final storage = GetStorage();
    userPhone = storage.read(userMobile) ?? '';
    userImage = storage.read(profileUrl) ?? '';
    userName = storage.read(firstName) ?? '';
  }

  bool isCurrentDay({required String currentDay}) {
    DateTime dateTime = DateTime.now();
    final day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day.toString();
    return day == currentDay;
  }

  void deleteEvent(
      {required String eventId,
      required EventsCreated eventsCreated,
      bool? deleteForMe,
      bool? deleteForEveryone}) async {
    showLoaderDialog(context: Get.context!);
    final res =
        await service.deleteEventApi(eventId: eventId, deleteForMe: deleteForMe, deleteForEveryone: deleteForEveryone);
    cancelDialog();
    if (res != null) {
      if (eventsCreated == EventsCreated.byUser) {
        eventListCreatedByUser?.removeWhere((element) => element.eventid == eventId);
      } else if (eventsCreated == EventsCreated.forUser) {
        eventListCreatedForUser?.removeWhere((element) => element.eventid == eventId);
      }
    }
    update();
  }

  void navigateToEventDetails({required EventResponseModel eventResponseModel, required EventsCreated eventsCreated}) {
    final repo = locator<CreatedEventRepo>();
    repo.setEvent(eventResponseModel);
    repo.setEventCreated(eventsCreated);
    repo.setUserType(UserType.registered);

    Get.toNamed(RoutesConst.eventCoverScreen);
  }

  Future<void> getEventsCreatedByUser() async {
    final res = await service.getAllEventsCreatedByUserApi();
    if (res != null && res.isNotEmpty) {
      eventListCreatedByUser = res;
    } else {
      eventListCreatedByUser = [];
    }
    update();
  }

  Future<void> getEventsCreatedForUser() async {
    final res = await service.getAllEventsCreatedForUserApi();
    if (res != null && res.isNotEmpty) {
      eventListCreatedForUser = res;
    } else {
      eventListCreatedForUser = [];
    }
    update();
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
