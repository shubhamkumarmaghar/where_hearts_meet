import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/binding/profile_setup_binding.dart';
import 'package:where_hearts_meet/auth_module/screens/profile_setup_screen.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_screen.dart';
import 'package:where_hearts_meet/event_module/binding/add_event_binding.dart';
import 'package:where_hearts_meet/event_module/binding/add_event_specials_binding.dart';
import 'package:where_hearts_meet/event_module/screens/add_event_specials_screen.dart';
import 'package:where_hearts_meet/show_event_module/binding/event_details_binding.dart';
import 'package:where_hearts_meet/event_module/screens/add_event_screen.dart';
import 'package:where_hearts_meet/show_event_module/view/created_event_list_screen.dart';
import 'package:where_hearts_meet/show_event_module/view/event_details_screen.dart';
import 'package:where_hearts_meet/show_event_module/view/events_list_screen.dart';
import 'package:where_hearts_meet/profile_module/binding/add_people_binding.dart';
import 'package:where_hearts_meet/profile_module/binding/people_list_binding.dart';
import 'package:where_hearts_meet/profile_module/screens/people_list_screen.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import '../../auth_module/binding/login_binding.dart';
import '../../auth_module/binding/signup_binding.dart';
import '../../auth_module/screens/login_screen.dart';
import '../../auth_module/screens/signup_screen.dart';
import '../../show_event_module/binding/created_event_list_binding.dart';
import '../../profile_module/binding/edit_profile_binding.dart';
import '../../profile_module/screens/add_people_screen.dart';
import '../../profile_module/screens/edit_profile_screen.dart';
import '../../show_event_module/binding/event_list_binding.dart';

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
      GetPage(
        name: RoutesConst.signUpScreen,
        binding: SignUpBinding(),
        page: () => SignUpScreen(),
      ),
      GetPage(
        name: RoutesConst.profileSetUpScreen,
        binding: ProfileSetupBinding(),
        page: () => ProfileSetupScreen(),
      ),
      GetPage(
        name: RoutesConst.addPeopleScreen,
        binding: AddPeopleBinding(),
        page: () => AddPeopleScreen(),
      ),
      GetPage(
        name: RoutesConst.addEventScreen,
        binding: AddEventBinding(),
        page: () => AddEventScreen(),
      ),
      GetPage(
        name: RoutesConst.peopleListScreen,
        binding: PeopleListBinding(),
        page: () => PeopleListScreen(),
      ),
      GetPage(
        name: RoutesConst.eventListScreen,
        binding: EventListBinding(),
        page: () => EventListScreen(),
      ),
      GetPage(
        name: RoutesConst.createdEventListScreen,
        binding: CreatedEventListBinding(),
        page: () => CreatedEventListScreen(),
      ),
      GetPage(
        name: RoutesConst.eventDetailsScreen,
        binding: EventDetailsBinding(),
        page: () => EventDetailsScreen(),
      ),
      GetPage(
        name: RoutesConst.AddEventSpecialsScreen,
        binding: AddEventSpecialsBinding(),
        page: () => AddEventSpecialsScreen(),
      ),
    ];
  }
}
