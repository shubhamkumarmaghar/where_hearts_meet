import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/binding/profile_setup_binding.dart';
import 'package:where_hearts_meet/auth_module/screens/profile_setup_screen.dart';
import 'package:where_hearts_meet/create_event/binding/create_event_binding.dart';
import 'package:where_hearts_meet/create_event/binding/create_gifts_binding.dart';
import 'package:where_hearts_meet/create_event/binding/create_timeline_binding.dart';
import 'package:where_hearts_meet/create_event/view/create_event_splash_screen.dart';
import 'package:where_hearts_meet/create_event/view/create_gifts_screen.dart';
import 'package:where_hearts_meet/create_event/widgets/select_gift_type_screen.dart';
import 'package:where_hearts_meet/dashboard_module/binding/dashboard_binding.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_screen.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import '../../auth_module/binding/login_binding.dart';
import '../../auth_module/screens/login_screen.dart';
import '../../create_event/binding/create_wishes_binding.dart';
import '../../create_event/view/create_event_screen.dart';
import '../../create_event/view/create_timeline_screen.dart';
import '../../create_event/view/create_wishes_screen.dart';
import '../../event_list/binding/event_list_binding.dart';
import '../../event_list/view/event_list_screen.dart';

import '../../preview_event/binding/created_wishes_preview_binding.dart';
import '../../preview_event/view/created_wishes_preview_screen.dart';
import '../../profile_module/binding/profile_binding.dart';

import '../../profile_module/screens/profile_screen.dart';
import '../guest_dashboard/binding/guest_dashboard_binding.dart';
import '../guest_dashboard/guest_home/binding/guest_home_binding.dart';
import '../guest_dashboard/guest_home/view/guest_home.dart';
import '../guest_dashboard/guest_wishlist/binding/guest_wishlist.dart';
import '../guest_dashboard/guest_wishlist/view/guest_wishlist.dart';
import '../guest_dashboard/view/guest_dashboard.dart';
import '../guest_dashboard/view/guest_splash_view.dart';
import '../create_event/binding/create_personal_wishes_binding.dart';
import '../create_event/view/create_personal_wishes_screen.dart';
import '../preview_event/binding/created_gifts_preview_binding.dart';
import '../preview_event/view/created_gifts_preview_screen.dart';

class AppRoutes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(name: RoutesConst.dashboardScreen, page: () => DashboardScreen(), binding: DashboardBinding()),
      GetPage(
        name: RoutesConst.profileScreen,
        binding: ProfileBinding(),
        page: () => ProfileScreen(),
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
        page: () => GuestWishList(),
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
      GetPage(
        name: RoutesConst.createPersonalWishesScreen,
        binding: CreatePersonalWishesBinding(),
        page: () => CreatePersonalWishesScreen(),
      ),
      GetPage(
        name: RoutesConst.createGiftsScreen,
        binding: CreateGiftsBinding(),
        page: () => CreateGiftsScreen(),
      ),
      GetPage(
        name: RoutesConst.selectGiftsScreen,
        binding: CreateGiftsBinding(),
        page: () => SelectGiftCardScreen(),
      ),
      GetPage(
        name: RoutesConst.createdWishesPreviewScreen,
        binding: CreatedWishesPreviewBinding(),
        page: () => CreatedWishesPreviewScreen(),
      ),
      GetPage(
        name: RoutesConst.createdGiftsPreviewScreen,
        binding: CreatedGiftsPreviewBinding(),
        page: () => CreatedGiftsPreviewScreen(),
      ),
      GetPage(
        name: RoutesConst.eventListScreen,
        binding: EventListBinding(),
        page: () => EventListScreen(),
      ),
    ];
  }
}
