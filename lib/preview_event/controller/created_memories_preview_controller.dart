import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../create_event/model/personal_memories_model.dart';

class CreatedMemoriesPreviewController extends BaseController {
  late List<PersonalMemoriesModel> memoriesList;
  RxInt pageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final res = Get.arguments as List<PersonalMemoriesModel>?;
    memoriesList = res ?? [];
  }
  void onPageChanged(int index){
    pageIndex.value = index;
  }
}
