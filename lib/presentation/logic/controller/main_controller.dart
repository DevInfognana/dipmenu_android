import 'package:dio/dio.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:dip_menu/presentation/logic/controller/profile_controller.dart';
import 'package:dip_menu/presentation/pages/favourite/favourite_screen.dart';
import 'package:dip_menu/presentation/pages/main/main_screen.dart';
import 'package:dip_menu/presentation/pages/profile/profile_screen.dart';
import 'package:dip_menu/presentation/pages/rewards/rewards_page_view.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:dip_menu/presentation/pages/search/search_screen.dart';
import 'package:get/get.dart';

// import '../../../core/enum/permission_handling.dart';
import '../../../data/model/cartlist_model.dart';
import 'dim_menu_search_controller.dart';
import 'favourite_controller.dart';

FavouriteController favouriteController = FavouriteController();
DipMenuSearchController searchController = DipMenuSearchController();
ProfileController profileController = ProfileController();

class MainController extends GetxController with StateMixin {
  int selectedIndex = 0;
  var tabs = [
    const HomeScreen(),
    const RewardsScreen(),
    // const SearchViewScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ].obs;

  int totalCount = 0;
  dynamic argumentData = Get.arguments;
  bool outValue = false;

  @override
  void onInit() {
    super.onInit();
    cartListApi();
    navigationMoved();
  }

  navigationMoved() {
    if (argumentData != null) {
      if (argumentData is int) {
        selectedIndex = argumentData ?? 0;
        bottomNavigation(argumentData);
      } else {
        // print(argumentData);
        // print(argumentData.runtimeType);
      }
    } else {
      selectedIndex = SharedPrefs.instance.getInt("bottomBar") == null
          ? 0
          : SharedPrefs.instance.getInt("bottomBar")!;
      bottomNavigation(selectedIndex);
    }
  }

  bottomNavigation(int index) {
    SharedPrefs.instance.setInt('bottomBar', index);
    update();
  }

  cartListApi() async {
    final data = {
      "payload": {
        "temp_token": SharedPrefs.instance.getString('tempToken') ?? ''
      }
    };
    await Dio()
        .post(
      BaseAPI.cartListApi,
      options: Options(headers: {
        'x-access-token': SharedPrefs.instance.getString('token') ?? ''
      }),
      data: data,
    )
        .then((response) {
      if (response.statusCode == 200) {
        totalCount = 0;
        var user = CartListData.fromJson(response.data);
        totalCount = user.data!.length;
      }
    });
    update();
  }

  // permissionHandler() {
  //   if (PermissionHandler.requestAllPermission() == false) {
  //     PermissionHandler.requestAllPermission();
  //   }
  // }

  onItemTapped(int index) {
    if (index == 4) {
      null;
    } else {
      change(selectedIndex = index);
      bottomNavigation(index);
    }
    if (index == 1) {
      searchController.viewHomeBanners();
    } else if (index == 3 &&
        SharedPrefs.instance.getString('user_id') != null) {
      profileController.profile(iD: SharedPrefs.instance.getString('user_id')!);
    } else if (index == 2 &&
        SharedPrefs.instance.getString('user_id') != null) {
      favouriteController.viewFavourites();
    }

    if (index != 1) {
      searchController.searchController.clear();
    }
  }

  onItemTapped1(int index) {
    if (index == 4) {
      null;
    } else {
      change(selectedIndex = index);
      bottomNavigation(index);
    }
    if (index == 2) {
      Get.offAllNamed(Routes.mainScreen, arguments: 2);
      favouriteController.viewFavourites();
      cartListApi();
    } else if (index == 1) {
      searchController.searchController.clear();
      Get.offAllNamed(Routes.mainScreen, arguments: 1);
    } else if (index == 0) {
      Get.offAllNamed(Routes.mainScreen, arguments: 0);
    } else if (index == 3) {
      Get.offAllNamed(Routes.mainScreen, arguments: 3);
      if(SharedPrefs.instance.getString('user_id') !=null){
        profileController.profile(iD: SharedPrefs.instance.getString('user_id')!);
      }

    }
  }

  willpopscope() {
    if (selectedIndex == 3) {
      change(outValue = false);
     change( selectedIndex = 0);
      Get.offAllNamed(Routes.mainScreen, arguments: 0);
    } else if (selectedIndex == 2) {
      change(outValue = false);
      change( selectedIndex = 0);
      Get.offAllNamed(Routes.mainScreen, arguments: 0);
    } else if (selectedIndex == 1) {
      change(outValue = false);
      change( selectedIndex = 0);
      Get.offAllNamed(Routes.mainScreen, arguments: 0);
    } else if (selectedIndex == 0) {
      change(outValue = true);
    }
    return outValue;
  }

}
