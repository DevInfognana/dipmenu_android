import 'package:dip_menu/presentation/logic/bindings/about_us_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/cart_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/contact_us_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/edit_profile_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/gift_card_history_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/main_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/payment_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/payment_detail_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/privacy_policy_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/product_list_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/product_preview_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/recent_order_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/recent_order_detail_binding.dart';
import 'package:dip_menu/presentation/logic/bindings/rewards_customize_edit_binding.dart';
import 'package:dip_menu/presentation/pages/about_us/about_us_screen.dart';
import 'package:dip_menu/presentation/pages/auth/forgot_password/forgot_password_screen.dart';
import 'package:dip_menu/presentation/pages/contact_us/contact_us_screen.dart';
import 'package:dip_menu/presentation/pages/gift_card_payment/gift_card/gift_card_history_screen.dart';
import 'package:dip_menu/presentation/pages/gift_card_payment/gift_card/gift_card_screen.dart';
import 'package:dip_menu/presentation/pages/payment/payment_screen.dart';
import 'package:dip_menu/presentation/pages/payment_detail/payment_detail_screen.dart';
import 'package:dip_menu/presentation/pages/preview_details/preview_screen.dart';
import 'package:dip_menu/presentation/pages/privacy_policy/privacy_policy_screen.dart';
import 'package:dip_menu/presentation/pages/product_list/product_list_screen.dart';
import 'package:dip_menu/presentation/pages/product_preview/product_view_screen.dart';
import 'package:dip_menu/presentation/pages/profile/edit_profile_screen.dart';
import 'package:dip_menu/presentation/pages/recent_order/recent_order_screen.dart';
import 'package:dip_menu/presentation/pages/recent_order_detail/recent_order_detail_screen.dart';
import 'package:dip_menu/presentation/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../logic/bindings/authentication_binding.dart';
import '../logic/bindings/customize_edit_binding.dart';
import '../logic/bindings/gift_card_binding.dart';
import '../logic/bindings/gift_card_payment_binding.dart';
import '../logic/bindings/google_payment_integration_binding.dart';
import '../logic/bindings/home_binding.dart';
import '../logic/bindings/preview_binding.dart';
import '../logic/bindings/rewards_binding.dart';
import '../logic/bindings/rewards_product_view_binding.dart';
import '../logic/bindings/sub_category_binding.dart';
import '../logic/controller/connection_manager_controller.dart';
import '../pages/auth/authentication_screen.dart';
import '../pages/auth/change_password/change_password_screen.dart';
import '../pages/auth/widget/singup_card.dart';
import '../pages/cart/cart_screen.dart';
import '../pages/gift_card_payment/gift_card_payment_screen.dart';
import '../pages/google_pay/google_payment.dart';
import '../pages/main/bottom_navigation.dart';
import '../pages/main/drive_thru/drive_thru_screen.dart';
import '../pages/product_preview/cutomize_edit_screen/product_edit_screen.dart';
import '../pages/rewards/rewards_page_view.dart';
import '../pages/rewards_product_preview/customize_screen/reward_edit_screen.dart';
import '../pages/rewards_product_preview/reward_product_view_screen.dart';
import '../pages/sub_category/sub_category_screen.dart';

class AppRoutes {
  static const splash = Routes.splashScreen;
  ConnectionManagerController controller =
      Get.find<ConnectionManagerController>();

  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: Routes.previewScreen,
        page: () => PreviewScreen(),
        bindings: [PreviewBinding()]),
    GetPage(
        name: Routes.loginScreen,
        page: () => AuthenticationScreen(),
        bindings: [AuthBindings()]),
    GetPage(
        name: Routes.signUpScreen,
        page: () => SignUpScreen(),
        bindings: [AuthBindings()]),
    GetPage(
        name: Routes.mainScreen,
        page: () => const MainScreen(),
        bindings: [MainBinding()]),
    GetPage(
        name: Routes.subCategoryScreen,
        page: () => const SubCategoryScreen(),
        bindings: [SubCategoryBinding()]),
    GetPage(
        name: Routes.productListScreen,
        page: () => const ProductListScreen(),
        bindings: [ProductListBinding()]),
    GetPage(
        name: Routes.cartScreen,
        page: () => CartScreen(),
        bindings: [CartBinding()]),
    GetPage(
        name: Routes.productPreviewScreen,
        page: () => const ProductPreviewScreen(),
        bindings: [ProductPreviewBinding()]),
    GetPage(
        name: Routes.forgotPasswordScreen,
        page: () => ForgotPasswordScreen(),
        bindings: [AuthBindings()]),
    GetPage(
        name: Routes.changePasswordScreen,
        page: () => ChangePasswordScreen(),
        bindings: [AuthBindings()]),
    GetPage(
        name: Routes.aboutUsScreen,
        page: () => AboutUsScreen(),
        bindings: [AboutUsBinding()]),
    GetPage(
        name: Routes.contactUsScreen,
        page: () => ContactUsScreen(),
        bindings: [ContactUsBinding()]),
    GetPage(
        name: Routes.profileScreen,
        page: () => const EditProfileScreen(),
        bindings: [EditProfileBinding()]),
    GetPage(
        name: Routes.privacyPolicyScreen,
        page: () => PrivacyPolicyScreen(),
        bindings: [PrivacyPolicyBinding()]),
    GetPage(
        name: Routes.recentOrderScreen,
        page: () => const RecentOrderScreen(),
        bindings: [RecentOrderBinding()]),
    GetPage(
        name: Routes.recentOrderDetailScreen,
        page: () => RecentOrderDetailScreen(),
        bindings: [RecentOrderDetailBinding()]),
    GetPage(
        name: Routes.paymentDetailScreen,
        page: () => PaymentDetailScreen(),
        bindings: [PaymentDetailBinding()]),
    GetPage(
        name: Routes.paymentScreen,
        page: () => PaymentScreen(),
        bindings: [PaymentBinding()]),
    GetPage(
        name: Routes.rewardsScreen,
        page: () => const RewardsScreen(),
        bindings: [RewardsBinding()]),
    GetPage(
        name: Routes.rewardsProductViewScreen,
        page: () => const RewardsProductPreviewScreen(),
        bindings: [RewardsProductBinding()]),
    GetPage(
        name: Routes.rewardsCustomizeScreen,
        page: () => const CustomizeRewardPreviewScreen(),
        bindings: [RewardsCustomizeProductBinding()]),
    GetPage(
        name: Routes.productCustomizeScreen,
        page: () => const CustomizeProductPreviewScreen(),
        bindings: [CustomizeEditBinding()]),
    GetPage(
        name: Routes.driveThruScreen,
        page: () => const DriveThruScreen(),
        bindings: [HomeBinding()]),
    GetPage(
        name: Routes.giftCardScreen,
        page: () => const GiftCardScreen(),
        bindings: [GiftCardBinding()]),
    GetPage(
        name: Routes.giftCardHistoryScreen,
        page: () => const GiftCardHistoryScreen(),
        bindings: [GiftCardHistoryBinding()]),
    GetPage(
        name: Routes.giftCardPaymentScreen,
        page: () => GiftPaymentScreen(),
        bindings: [GiftCardPaymentBinding()]),
    GetPage(
        name: Routes.googlePaymentScreen,
        page: () => const GooglePaymentScreen(),
        bindings: [GooglePaymentIntegrationBinding()]),
  ];
}

class Routes {
  static const splashScreen = '/splashScreen';
  static const previewScreen = '/previewScreen';
  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const mainScreen = '/mainScreen';
  static const homeScreen = '/homeScreen';
  static const subCategoryScreen = '/subCategoryScreen';
  static const productListScreen = '/productListScreen';
  static const cartScreen = '/cartScreen';
  static const productPreviewScreen = '/productPreviewScreen';
  static const aboutUsScreen = '/aboutUsScreen';
  static const contactUsScreen = '/contactUsScreen';
  static const profileScreen = '/profileScreen';
  static const privacyPolicyScreen = '/privacyPolicyScreen';
  static const recentOrderScreen = '/recentOrderScreen';
  static const recentOrderDetailScreen = '/recentOrderDetailScreen';
  static const paymentDetailScreen = '/paymentDetailScreen';
  static const paymentScreen = '/paymentScreen';
  static const rewardsScreen = '/rewardsScreen';
  static const productCustomizeScreen = '/productCustomizeScreen';
  static const rewardsCustomizeScreen = '/rewardsCustomizeScreen';
  static const rewardsProductViewScreen = '/rewardsProductViewScreen';
  static const driveThruScreen = '/driveThruScreen';
  static const giftCardScreen = '/giftCardScreen';
  static const giftCardHistoryScreen = '/giftCardHistoryScreen';
  static const giftCardPaymentScreen = '/giftCardPaymentScreen';
  static const googlePaymentScreen = '/googlePaymentScreen';
}
