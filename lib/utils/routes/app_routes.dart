import 'package:get/get.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_screen.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';

class AppRoutes{

  static List<GetPage> getRoutes() {
    final routesList = <GetPage>[
      GetPage(
        name: RoutesConst.dashboardScreen,
        page: () => DashboardScreen(),
        //binding: MotorBrandBindings(),
       // arguments: MotorReqParamArguments(),
      ),
    ];
    return routesList;
  }

}