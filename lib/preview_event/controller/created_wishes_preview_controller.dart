import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/model/wishes_model.dart';
import 'package:where_hearts_meet/preview_event/service/preview_events_service.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../create_event/model/event_response_model.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/repository/created_event_repo.dart';

class CreatedWishesPreviewController extends BaseController {
  late EventResponseModel eventResponseModel;
  late WishesModel wishesModel;
  final service = PreviewEventService();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    if (createdEvent.getCurrentEvent != null) {
      eventResponseModel = createdEvent.getCurrentEvent!;
    }
    wishesModel = Get.arguments as WishesModel;
  }

  void deleteWish() async {
    showLoaderDialog(context: Get.context!);
    final res = await service.deleteWishApi(wishId: wishesModel.id ?? -1);
    cancelDialog();
    if (res != null) {
      Get.back(result:  wishesModel.id);
    }
  }
}
