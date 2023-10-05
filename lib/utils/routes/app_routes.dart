import 'package:get/get.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_screen.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import '../../auth_module/binding/login_binding.dart';
import '../../auth_module/screens/login_screen.dart';
import '../../edit_profile_module/binding/edit_profile_binding.dart';
import '../../edit_profile_module/screens/edit_profile_screen.dart';

class AppRoutes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: RoutesConst.dashboardScreen,
        page: () => DashboardScreen(),
      ),
      GetPage(
        name: RoutesConst.editProfileScreen,
        binding: EditProfileBinding(),
        page: () => EditProfileScreen(),
      ),
      GetPage(
        name: RoutesConst.loginScreen,
        binding: LoginBinding(),
        page: () => LoginScreen(),
      ),
    ];
  }
}
