import 'dart:math';

import 'package:get/get.dart';
import 'package:heart_e_homies/utils/consts/color_const.dart';
import 'package:heart_e_homies/utils/controller/base_controller.dart';
import 'package:heart_e_homies/utils/widgets/util_widgets/app_widgets.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/wishes_model.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/dialogs/pop_up_dialogs.dart';
import '../../../utils/repository/created_event_repo.dart';
import '../../service/view_event_service.dart';

class WishesController extends BaseController {
  List<WishesModel>? wishesList;
  final _eventService = ViewEventService();
  late String eventId;
  late EventsCreated eventsCreated;
  late UserType userType;
  bool canUpdateWishes = false;

  @override
  void onInit() {
    super.onInit();
    final repo = locator<CreatedEventRepo>();
    final event = repo.getCurrentEvent ?? EventResponseModel();
    eventId = event.eventid ?? '';
    eventsCreated = repo.getCurrentEventCreated ?? EventsCreated.byUser;
    userType = repo.getUserType ?? UserType.registered;
    if (eventId.isNotEmpty) {
      getEventWishes(eventId);
      if (eventsCreated == EventsCreated.byUser) {
        canUpdateWishes = true;
      }
    }
  }

  void deleteWish(WishesModel wishesModel) async {
    if (wishesList != null && wishesList!.length == 1) {
      AppWidgets.getToast(message: 'There should be Atleast 1 wish',color: errorColor);
      return;
    }
    showLoaderDialog(context: Get.context!);
    final res = await _eventService.deleteWishApi(wishId: wishesModel.id ?? -1);
    cancelDialog();
    if (res != null) {
      wishesList?.removeWhere((element) => element.id == wishesModel.id);
      update();
    }
  }

  void navigateToAddWishes() async {
    final repo = locator<CreatedEventRepo>();
    repo.setAppActions(AppActions.update);
    final res = await Get.toNamed(RoutesConst.createWishesScreen);
    if (res != null && res as bool == true) {
      showLoaderDialog(context: Get.context!);
      getEventWishes(eventId);
      repo.setAppActions(AppActions.view);
      cancelDialog();
    }
  }

  Future<void> getEventWishes(String eventId) async {
    var res = await _eventService.fetchWishesList(eventId: eventId);
    wishesList = res ?? [];
    update();
  }
}
