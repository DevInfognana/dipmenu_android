import 'package:dip_menu/presentation/logic/controller/profile_controller.dart';
import 'package:dip_menu/presentation/pages/profile/widget/profile_list_card_screen.dart';
import 'package:dip_menu/presentation/pages/profile/widget/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.find<ProfileController>();

  final numberFormat = NumberFormat("#,##0.00", "en_US");


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: AppBar(
                leading: AuthBackButton(press: () {
                  Get.offAllNamed(Routes.mainScreen, arguments: 0);
                }),
                centerTitle: true,
                title: TextScaleFactorClamper(
                    child: AuthTitleText(text: NameValues.myProfile)))),
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: TextScaleFactorClamper(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.only(bottom: 2.h, left: 2.w, right: 2.w),
                  child: SharedPrefs.instance.getString('token') != null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GetBuilder<ProfileController>(
                                builder: (controller) {
                              return controller.status.isLoading
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                          color: mainColor))
                                  : Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              null;
                                            },
                                            child: ProfilePictureView(
                                              imageUrl: controller.imageUrl,
                                              name: controller.name,
                                              mobileNumber:
                                                  controller.mobileNumber,
                                              onChanged1: () {
                                                Get.toNamed(
                                                    Routes.profileScreen,
                                                    arguments: controller
                                                        .profileValues);
                                              },
                                            )),
                                         DividerView( values: 0),
                                        ProfileListValues(
                                            onChanged: () {
                                              Get.toNamed(
                                                  Routes.changePasswordScreen,
                                                  arguments: profileController
                                                      .profileValues!.id!);
                                            },
                                            title: NameValues.changePassword,
                                            icon: Icons.key_off),
                                         DividerView( values: 0),
                                        ListTileShow2(
                                            title: NameValues.rewards,
                                            values:
                                                '${controller.rewardpoints!} Points',
                                            icon1: Icons.shopify_outlined),
                                         DividerView( values: 0),
                                        ListTileShow1(
                                            title: NameValues.wallet,
                                            values:
                                                '\$ ${numberFormat.format(double.parse(SharedPrefs.instance.getString('wallet')!))}',
                                            icon1: Icons
                                                .account_balance_wallet_outlined,
                                            icon2: Icons.wallet_membership),
                                        DividerView( values: 0),
                                      ],
                                    );
                            }),
                            ProfileListValues(
                                onChanged: () {
                                  Get.toNamed(Routes.rewardsScreen);
                                },
                                title: NameValues.rewardsProduct,
                                icon: Icons.star_border_outlined),
                             DividerView( values: 0),
                            darkModeValues(),
                             DividerView( values: 0),
                            ProfileListValues(
                                onChanged: () {
                                  Get.toNamed(Routes.recentOrderScreen);
                                },
                                title: NameValues.myOrders,
                                icon: Icons.shopping_bag_outlined),
                             DividerView( values: 0),
                            ProfileExpanisonValues(
                                onCreateGiftChanged: () {
                                  Get.toNamed(Routes.giftCardScreen);
                                },
                                onPurchasedHistoryChanged: () {
                                  Get.toNamed(Routes.giftCardHistoryScreen,
                                      arguments: 'PurchaseHistory');
                                },
                                onTransactionsHistoryChanged: () {
                                  Get.toNamed(Routes.giftCardHistoryScreen,
                                      arguments: 'TranscationHistory');
                                },
                                title: NameValues.giftCard,
                                icon: Icons.redeem,
                                title1: NameValues.createGiftCard,
                                title2: NameValues.purchasedGiftCards,
                                title3: NameValues.myTransactions),
                             DividerView( values: 0),
                            ProfileListValues(
                                onChanged: () {
                                  Get.toNamed(Routes.aboutUsScreen);
                                },
                                title: NameValues.aboutUs,
                                icon: Icons.person_pin_circle_outlined),
                             DividerView( values: 0),
                            ProfileListValues(
                                onChanged: () {
                                  Get.toNamed(Routes.contactUsScreen);
                                },
                                title: NameValues.contactUs,
                                icon: Icons.contact_support_outlined),
                             DividerView( values: 0),
                            ProfileListValues(
                                onChanged: () {
                                  Get.toNamed(Routes.privacyPolicyScreen);
                                },
                                title: NameValues.privacyPollicy,
                                icon: Icons.privacy_tip_outlined),
                             DividerView( values: 0),
                            ProfileListValues(
                                onChanged: () {
                                  showAlertDialog(context);
                                },
                                title: NameValues.logout,
                                icon: Icons.logout),
                             DividerView( values: 0),
                            ProfileListValues(
                                onChanged: () {
                                  showAlertDialogDeleteAccount(context);
                                },
                                title: NameValues.deleteAccount,
                                icon: Icons.delete),
                            DividerView( values: 0),
                          ],
                        )
                      : GetBuilder<ProfileController>(builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.offNamed(Routes.loginScreen);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            top: 2.h, left: 2.h, right: 2.h),
                                        child: Icon(Icons.account_circle,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black45,
                                            size: 15.w)),
                                    Text(NameValues.withoutLogin.tr,
                                        style: context.theme.textTheme.headlineMedium
                                            ?.copyWith(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w700))
                                  ],
                                ),
                              ),
                               DividerView( values: 0),
                              darkModeValues(),
                               DividerView( values: 0),
                              ProfileListValues(
                                  onChanged: () {
                                    Get.toNamed(Routes.aboutUsScreen);
                                  },
                                  title: NameValues.aboutUs,
                                  icon: Icons.person_pin_circle_outlined),
                               DividerView( values: 0),
                              ProfileListValues(
                                  onChanged: () {
                                    Get.toNamed(Routes.contactUsScreen);
                                  },
                                  title: NameValues.contactUs,
                                  icon: Icons.contact_support_outlined),
                               DividerView( values: 0),
                              ProfileListValues(
                                  onChanged: () {
                                    Get.toNamed(Routes.privacyPolicyScreen);
                                  },
                                  title: NameValues.privacyPollicy,
                                  icon: Icons.privacy_tip_outlined),
                               DividerView( values: 0),
                            ],
                          );
                        }))),
        ),
      ),
    );
  }

  showAlertDialog(context) {
    ShowDialogBox.showAlertDialog(
      content: 'Are you sure you want to log out?',
      context: context,
      title: 'Logout',
      textBackButton: "NO",
      textOkButton: "Yes",
      onButtonTapped: () {
        Get.offNamed(Routes.mainScreen,
            arguments: profileController.logoutValues());
      },
    );
  }

  //For Delete Account
  showAlertDialogDeleteAccount(context) {
    ShowDialogBox.showAlertDialog(
      content: 'Are you sure you want to delete your account?',
      context: context,
      title: 'Confirm Deletion',
      textBackButton: "NO",
      textOkButton: "Yes",
      onButtonTapped: () {
        profileController.deleteAccount();
        Get.offNamed(Routes.mainScreen,
            arguments: profileController.logoutValues());
      },
    );
  }


  darkModeValues() {
    Color? color = Get.isDarkMode ? Colors.white : borderColor;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 1.w, right: 5.w),
      leading: FittedBox(
          fit: BoxFit.fill,
          child: Icon(Icons.dark_mode, color: color, size: 16.sp)),
      title: Text('Dark Theme',
          style: context.theme.textTheme.headlineMedium!
              .copyWith(color: color, fontWeight: FontWeight.w400)),
      trailing: GetBuilder<ProfileController>(builder: (controller) {
        return Switch(
          value: profileController.isDarkMode.value,
          activeColor: Colors.white,
          inactiveTrackColor: Colors.grey,
          onChanged: (isOn) {
            profileController.toggleChanges(isOn);
          },
        );
      }),
    );
  }
}
