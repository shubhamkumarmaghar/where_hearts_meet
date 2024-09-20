import 'package:get/get.dart';
import 'package:heart_e_homies/auth_module/binding/otp_screen_binding.dart';
import 'package:heart_e_homies/auth_module/screens/otp_screen.dart';
import 'package:heart_e_homies/routes/routes_const.dart';
import '../../auth_module/binding/login_binding.dart';
import '../../auth_module/screens/login_screen.dart';
import '../../create_event/binding/create_wishes_binding.dart';
import '../../create_event/view/create_event_screen.dart';
import '../../create_event/view/create_personal_decorations_screen.dart';
import '../../create_event/view/create_wishes_screen.dart';
import '../../event_list/binding/event_list_binding.dart';
import '../../event_list/view/event_list_screen.dart';

import '../../preview_event/binding/created_wishes_preview_binding.dart';
import '../../preview_event/view/created_wishes_preview_screen.dart';
import '../../profile_module/binding/profile_binding.dart';

import '../../profile_module/screens/profile_screen.dart';
import '../create_event/binding/create_event_binding.dart';
import '../create_event/binding/create_gifts_binding.dart';
import '../create_event/binding/create_personal_decorations_binding.dart';
import '../create_event/binding/create_personal_memories_binding.dart';
import '../create_event/binding/create_personal_messages_binding.dart';
import '../create_event/view/create_event_splash_screen.dart';
import '../create_event/view/create_gifts_screen.dart';
import '../create_event/view/create_personal_memories_screen.dart';
import '../create_event/view/create_personal_messages_screen.dart';
import '../create_event/widgets/select_gift_type_screen.dart';
import '../dashboard_module/binding/dashboard_binding.dart';
import '../dashboard_module/screens/dashboard_screen.dart';
import '../guest_dashboard/binding/guest_dashboard_binding.dart';
import '../guest_dashboard/guest_home/binding/guest_home_binding.dart';
import '../guest_dashboard/guest_home/view/guest_home.dart';
import '../guest_dashboard/guest_wishlist/binding/guest_wishlist_binding.dart';
import '../guest_dashboard/guest_wishlist/view/guest_wishlist.dart';
import '../guest_dashboard/view/guest_dashboard.dart';
import '../guest_dashboard/guest_home/view/guest_splash_view.dart';
import '../create_event/binding/create_personal_cover_binding.dart';
import '../create_event/view/create_personal_cover_screen.dart';
import '../guest_dashboard/view/guest_event_qr_scanner.dart';
import '../preview_event/binding/created_gifts_preview_binding.dart';
import '../preview_event/binding/created_memories_preview_binding.dart';
import '../preview_event/view/created_gifts_preview_screen.dart';
import '../preview_event/view/created_memories_preview_screen.dart';
import '../view_event_details/e_gifts/binding/e_gifts_binding.dart';
import '../view_event_details/e_gifts/view/e_gifts_screen.dart';
import '../view_event_details/personal_wishes/binding/personal_decorations_binding.dart';
import '../view_event_details/personal_wishes/binding/personal_messages_binding.dart';
import '../view_event_details/personal_wishes/view/personal_decorations_screen.dart';
import '../view_event_details/personal_wishes/view/personal_messages_screen.dart';

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
        name: RoutesConst.guestQrScannerScreen,
        binding: GuestDashboardBinding(),
        page: () => const EventQrScannerScreen(),
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
        name: RoutesConst.personalMessagesScreen,
        binding: PersonalMessagesBinding(),
        page: () => const PersonalMessagesScreen(),
      ),
      GetPage(
        name: RoutesConst.personalDecorationsScreen,
        binding: PersonalDecorationsBinding(),
        page: () => const PersonalDecorationsScreen(),
      ),
      GetPage(
        name: RoutesConst.eGiftsScreen,
        binding: EGiftsBinding(),
        page: () => const EGiftsScreen(),
      ),
      GetPage(
        name: RoutesConst.createEventScreen,
        binding: CreateEventBinding(),
        page: () => CreateEventScreen(),
      ),
      GetPage(
        name: RoutesConst.otpScreen,
        binding: OtpScreenBinding(),
        page: () => OtpScreen(),
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
        name: RoutesConst.createPersonalDecorationsScreen,
        binding: CreatePersonalDecorationsBinding(),
        page: () => CreatePersonalDecorationsScreen(),
      ),
      GetPage(
        name: RoutesConst.CreatePersonalCoverScreen,
        binding: CreatePersonalCoverBinding(),
        page: () => CreatePersonalCoverScreen(),
      ),
      GetPage(
        name: RoutesConst.createPersonalMemoriesScreen,
        binding: CreatePersonalMemoriesBinding(),
        page: () => CreatePersonalMemoriesScreen(),
      ),
      GetPage(
        name: RoutesConst.createPersonalMessagesScreen,
        binding: CreatePersonalMessagesBinding(),
        page: () => CreatePersonalMessagesScreen(),
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
          name: RoutesConst.createdMemoriesPreviewScreen,
          binding: CreatedMemoriesPreviewBinding(),
          page: () => const CreatedMemoriesPreviewScreen()),
      GetPage(
        name: RoutesConst.eventListScreen,
        binding: EventListBinding(),
        page: () => EventListScreen(),
      ),
    ];
  }
}
