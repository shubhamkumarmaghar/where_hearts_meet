import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/model/wishes_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../create_event/model/event_response_model.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/repository/created_event_repo.dart';

class CreatedWishesPreviewController extends BaseController {
  late EventResponseModel eventResponseModel;
  late WishesModel wishesModel;

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    if (createdEvent.getCurrentEvent != null) {
      eventResponseModel = createdEvent.getCurrentEvent!;
    }
    wishesModel = Get.arguments as WishesModel;
  }
}
