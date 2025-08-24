import 'package:dip_menu/presentation/pages/search/widget/search_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controller/dim_menu_search_controller.dart';
import '../main/widget/search_text_form_field.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class SearchViewScreen extends StatefulWidget {
  const SearchViewScreen({Key? key}) : super(key: key);

  @override
  State<SearchViewScreen> createState() => _SearchViewScreenState();
}

class _SearchViewScreenState extends State<SearchViewScreen> {
  final searchListController = Get.find<DipMenuSearchController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DipMenuSearchController>(builder: (_) {
        return HandlingDataView(
            statusRequest: searchListController.statusRequestSearchValues,
            widget: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(7.7.h),
                child: AppBar(
                    leading: AuthBackButton(
                      press: () {
                        Get.offAllNamed(Routes.mainScreen, arguments: 0);
                      },
                    ),
                    centerTitle: true,
                    title: TextScaleFactorClamper(
                        child: AuthTitleText(text: NameValues.products))),
              ),
              body: TextScaleFactorClamper(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 2.h, right: 2.h, left: 2.h),
                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.focusedChild?.unfocus();
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(4.w),
                            child: SearchTextFromField(
                              controller: searchListController.searchController,
                              obscureText: false,
                              hintText: 'Discover Food Items'.tr,
                              prefixIcon:
                                  const Icon(Icons.search, color: hintColor),
                              textInputAction: TextInputAction.search,
                              onEditingCompleted: () {
                                if (searchListController
                                    .searchController.text.isNotEmpty) {
                                  searchListController.viewSearchServices(
                                      searchListController.searchController.text
                                          .trim());
                                  FocusManager.instance.primaryFocus?.unfocus();
                                } else {
                                  searchListController.viewHomeBanners();
                                }
                              },
                              onChanged: (value) {
                                searchListController.onSearchChanged(value);
                              },
                              //suffixIcon: null == suffixIcon ? null : Icon(suffixIcon),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    searchListController.searchController
                                        .clear();
                                    searchListController.viewHomeBanners();
                                  },
                                  child: const Icon(Icons.clear,
                                      color: hintColor)),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        SearchCard(controller: searchListController)
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
