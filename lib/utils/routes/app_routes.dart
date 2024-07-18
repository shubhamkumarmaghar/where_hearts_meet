import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/binding/profile_setup_binding.dart';
import 'package:where_hearts_meet/auth_module/screens/profile_setup_screen.dart';
import 'package:where_hearts_meet/create_event/binding/create_event_binding.dart';
import 'package:where_hearts_meet/create_event/binding/create_timeline_binding.dart';
import 'package:where_hearts_meet/create_event/controller/create_event_controller.dart';
import 'package:where_hearts_meet/create_event/view/create_event_splash_screen.dart';
import 'package:where_hearts_meet/create_event_module/screens/add_giftcard_screen.dart';
import 'package:where_hearts_meet/create_event_module/screens/add_secret_wishes_screen.dart';
import 'package:where_hearts_meet/create_event_module/screens/add_timeline_screen.dart';
import 'package:where_hearts_meet/create_event_module/screens/add_wishes_screen.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_screen.dart';
import 'package:where_hearts_meet/guest/guest_dashboard/guest_wishlist/view/guest_wishlist.dart';
import 'package:where_hearts_meet/show_event_module/binding/event_details_binding.dart';
import 'package:where_hearts_meet/show_event_module/view/event_details_screen.dart';
import 'package:where_hearts_meet/show_event_module/view/events_list_screen.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import '../../auth_module/binding/login_binding.dart';
import '../../auth_module/screens/login_screen.dart';
import '../../create_event/binding/create_wishes_binding.dart';
import '../../create_event/view/create_event_screen.dart';
import '../../create_event/view/create_timeline_screen.dart';
import '../../create_event/view/create_wishes_screen.dart';
import '../../create_event_module/binding/add_event_binding.dart';
import '../../create_event_module/binding/add_event_specials_binding.dart';
import '../../create_event_module/screens/add_event_screen.dart';
import '../../create_event_module/screens/add_event_specials_screen.dart';
import '../../guest/guest_dashboard/binding/guest_dashboard_binding.dart';
import '../../guest/guest_dashboard/guest_home/binding/guest_home_binding.dart';
import '../../guest/guest_dashboard/guest_home/view/guest_home.dart';
import '../../guest/guest_dashboard/guest_wishlist/binding/guest_wishlist.dart';
import '../../guest/guest_dashboard/view/guest_dashboard.dart';
import '../../guest/guest_dashboard/view/guest_dashboard.dart';
import '../../guest/guest_dashboard/view/guest_splash_view.dart';
import '../../profile_module/binding/edit_profile_binding.dart';

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
        name: RoutesConst.profileSetUpScreen,
        binding: ProfileSetupBinding(),
        page: () => ProfileSetupScreen(),
      ),
      GetPage(
        name: RoutesConst.addEventScreen,
        binding: AddEventBinding(),
        page: () => AddEventScreen(),
      ),
      GetPage(
        name: RoutesConst.eventListScreen,
        binding: EventListBinding(),
        page: () => EventListScreen(),
      ),
      GetPage(
        name: RoutesConst.eventDetailsScreen,
        binding: EventDetailsBinding(),
        page: () => EventDetailsScreen(),
      ),
      GetPage(
        name: RoutesConst.addEventSpecialsScreen,
        binding: AddEventSpecialsBinding(),
        page: () => const AddEventSpecialsScreen(),
      ),
      GetPage(
        name: RoutesConst.addWishesScreen,
        //binding: AddEventSpecialsBinding(),
        page: () => const AddWishesScreen(),
      ),
      GetPage(
        name: RoutesConst.addGiftCardScreen,
        // binding: AddEventSpecialsBinding(),
        page: () => const AddGiftCardScreen(),
      ),
      GetPage(
        name: RoutesConst.addTimelineScreen,
        // binding: AddEventSpecialsBinding(),
        page: () => const AddTimelineScreen(),
      ),
      GetPage(
        name: RoutesConst.secretWishesScreen,
        // binding: AddEventSpecialsBinding(),
        page: () => const AddSecretWishesScreen(),
      ),
      GetPage(
        name: RoutesConst.guestHomeScreen,
         binding: GuestHomeBinding(),
        page: () => const GuestHome(),
      ),
      GetPage(
        name: RoutesConst.guestDashboard,
        binding: GuestDashboardBinding(),
        page: () => const GuestDashboard(),
      ),
      GetPage(
        name: RoutesConst.guestWishlist,
        binding: GuestWishlistBinding(),
        page: () =>  GuestWishList(),
      ),
      GetPage(
        name: RoutesConst.guestCoverScreen,
        binding: GuestDashboardBinding(),
        page: () => const GuestCoverScreen(),
      ),
      GetPage(
        name: RoutesConst.createEventScreen,
        binding: CreateEventBinding(),
        page: () => CreateEventScreen(),
      ),
      GetPage(
        name: RoutesConst.createEventSplashScreen,
        binding: CreateEventBinding(),
        page: () => CreateEventSplashScreen(),
      ),
      GetPage(
        name: RoutesConst.createWishesScreen,
        binding: CreateWishesBinding(),
        page: () => CreateWishesScreen(),
      ),
      GetPage(
        name: RoutesConst.createTimelineScreen,
        binding: CreateTimelineBinding(),
        page: () => CreateTimelineScreen(),
      ),
    ];
  }
}
