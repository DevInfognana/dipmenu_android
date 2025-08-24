import 'package:flutter/material.dart';
import 'package:dip_menu/presentation/logic/controller/privacy_policy_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'package:dip_menu/presentation/pages/index.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({Key? key}) : super(key: key);
  final privacyPolicyController = Get.find<PrivacyPolicyController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: AuthBackButton(
                press: () {
                  Get.back();
                },
              ),
              centerTitle: true,
              title: TextScaleFactorClamper(
                  child: AuthTitleText(text: NameValues.privacyPollicy))),
          body: TextScaleFactorClamper(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: HtmlView(
                                      text: PrivacyPolicy.privacyPolicy1)),
                            ]),
                        SizedBox(height: 3.h),
                        bodyTag(PrivacyPolicy.privacyPolicy2),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicy3),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicy4),
                        SizedBox(height: 2.h),
                        bodyTag(PrivacyPolicy.privacyPolicyLocationAccessTittle),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicyLocationAccessContent),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicyLocationAccessPoint1),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicyLocationAccessPoint2),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicyLocationAccessPoint3),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicyLocationAccessPoint4),
                        SizedBox(height: 2.h),
                        headlineTag(PrivacyPolicy.privacyPolicy5, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.privacyPolicy6),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.collectioOfInfoTitle),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.collectioOfInfoContent1),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.collectioOfInfoContent2),
                        SizedBox(height: 2.h),
                        headlineTag(PrivacyPolicy.sharingInfoTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.sharingInfoContent1),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.sharingInfoContent2),
                        SizedBox(height: 2.h),
                        headlineTag(
                            PrivacyPolicy.autoSharingInfoTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.autoSharingInfoContent),
                        SizedBox(height: 2.h),
                        headlineTag(PrivacyPolicy.useCookiesTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.useCookiesContent),
                        SizedBox(height: 2.h),
                        headlineTag(
                            PrivacyPolicy.securityPersonalInfoTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.securityPersonalInfoContent),
                        SizedBox(height: 2.h),
                        headlineTag(
                            PrivacyPolicy.childrenthirteenTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.childrenthirteenContent),
                        SizedBox(height: 2.h),
                        headlineTag(
                            PrivacyPolicy.changesStatementTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.changesStatementContent),
                        SizedBox(height: 2.h),
                        headlineTag(PrivacyPolicy.questionsTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.questionsContent),
                        SizedBox(height: 2.h),
                        headlineTag(PrivacyPolicy.refundPolicyTitle, context),
                        SizedBox(height: 1.h),
                        bodyTag(PrivacyPolicy.refundPolicyContent),
                        SizedBox(height: 1.h),
                        //For web url link
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Expanded(
                        //         child: Html(
                        //           data: """
                        //                   <p>
                        //                     By using this app, you also view to our
                        //                     <a href="https://www.w3schools.com/about/about_privacy.asp">Privacy Policy</a>.
                        //                   </p>
                        //                   """,
                        //           onLinkTap: (String? url, Map<String, String> attributes, element) {
                        //             if (url != null) {
                        //               // Navigate to a new screen with WebView
                        //               Get.to(() => WebViewScreen(url: url));
                        //             }
                        //           },
                        //         ),
                        //       ),
                        //     ]),
                        SizedBox(height: 5.h)
                      ]))))),
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  testStyle() {
    return Style(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: FontSize(getDeviceType() == 'phone' ? 20 : 17));
  }

  headlineTag(String values1, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: TextScaleFactorClamper(
              child: Text(values1,  //PrivacyPolicy.privacyPolicy2,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold))))
    ]);
  }

  bodyTag(String values) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Expanded(child: HtmlView(text: values))]);
  }
}


class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(url),
          // url: Uri.parse(url), // Compatible with older version
        ),
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true, // Keeps it optimized for Android
          ),
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true, // Enable JavaScript
            supportZoom: true, // Support zoom gestures
          ),
        ),

        onLoadError: (controller, url, code, description) {
          print("Load error: $description");
        },
      ),
    );
  }
}

