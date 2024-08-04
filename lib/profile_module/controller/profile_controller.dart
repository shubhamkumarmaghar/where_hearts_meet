import 'package:where_hearts_meet/profile_module/service/profile_serice.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import '../model/user_model.dart';

class ProfileController extends BaseController {
  UserModel userModel = UserModel();
  final profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    setBusy(true);
    final response = await profileService.userDataApi();
    setBusy(false);
    if (response != null) {
      userModel = response;
      update();
    }

  }
}
