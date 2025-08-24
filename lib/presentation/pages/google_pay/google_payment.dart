

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../../../core/config/icon_config.dart';
import '../../../core/config/theme.dart';
import '../../../core/static/stactic_values.dart';
import '../../../extra/common_widgets/back_button.dart';
import '../../logic/controller/google_payment_integration_controller.dart';
import '../../routes/routes.dart';

// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class GooglePaymentScreen extends StatefulWidget {
  const GooglePaymentScreen({Key? key}) : super(key: key);

  @override
  State<GooglePaymentScreen> createState() => _GooglePaymentScreenState();
}

class _GooglePaymentScreenState extends State<GooglePaymentScreen> {
  final googlePaymentController =
      Get.find<GooglePaymentIntegrationController>();


  ContextMenu? contextMenu;


  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    // setState(() {
    //
    // });
  }
  //

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        Get.offAllNamed(Routes.cartScreen);
        return   googlePaymentController.status.isLoading ?  false : true;
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
                leading: AuthBackButton(
                  press: () {

                    if(googlePaymentController.pageView == 'OrderPage'){
                      Get.offAllNamed(Routes.cartScreen);
                    }else if (googlePaymentController.pageView == 'TopUpWallet') {
                      // Get.offAllNamed(Routes.mainScreen, arguments: 3);
                      Get.back();
                    }
                    else if (googlePaymentController.pageView == 'buyGiftCard') {
                      Get.back();
                    }

                  },
                ),
                centerTitle: true,
                title: AuthTitleText(text: NameValues.payment))),
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemesApp.light.scaffoldBackgroundColor,
        body: GetBuilder<GooglePaymentIntegrationController>(
          builder: (controller) {
            return controller.status.isLoading
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(ImageAsset.loadingFailed,
                          height: 40.h,
                          width: 10.w,
                          reverse: true,
                          fit: BoxFit.fill),
                    ],
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: EdgeInsets.all(2.h),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: InAppWebView(
                            initialUrlRequest: URLRequest(
                                // url: Uri.parse(
                                url: WebUri(
                                    googlePaymentController.paymentUrl!)),
                            contextMenu: contextMenu,
                            initialOptions: InAppWebViewGroupOptions(
                                crossPlatform: InAppWebViewOptions(
                                    // userAgent:'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148' ,
                                    transparentBackground: true,
                                    disableHorizontalScroll:true,
                                    // preferredContentMode:UserPreferredContentMode.MOBILE,
                                    javaScriptCanOpenWindowsAutomatically: true,
                                    mediaPlaybackRequiresUserGesture: false),
                                android: AndroidInAppWebViewOptions(
                                    allowContentAccess: true,
                                    supportMultipleWindows: true),

                                ios: IOSInAppWebViewOptions(
                                    enableViewportScale: true,
                                    applePayAPIEnabled: true,
                                    allowsInlineMediaPlayback: true,)),
                            onWebViewCreated: (controller) async {
                              controller = controller;
                              googlePaymentController.webViewController =
                                  controller;
                            },
                            onCreateWindow:
                                (controller, createWindowRequest) async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 400,
                                      color: Colors.red,
                                      child: InAppWebView(
                                        // Setting the windowId property is important here!
                                        windowId: createWindowRequest.windowId,
                                        initialOptions:
                                            InAppWebViewGroupOptions(
                                                crossPlatform:
                                                    InAppWebViewOptions()),
                                        // onWebViewCreated: (controller) async {
                                        //   controller = controller;
                                        //   controller.clearCache();
                                        //   webViewController = controller;
                                        // },
                                        onWebViewCreated:
                                            (InAppWebViewController
                                                controller1) {
                                          googlePaymentController
                                                  .webViewPopController =
                                              controller1;
                                        },
                                        onLoadStart: (controller1, url) {
                                          // print("onLoadStart popup $url");
                                        },
                                        onLoadStop: (controller1, url) {
                                          // print("onLoadStop popup $url");
                                          googlePaymentController
                                              .viewOfPage(url.toString());
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );

                              return true;
                            },
                            shouldOverrideUrlLoading:
                                (controller, navigationAction) async {
                              var uri = navigationAction.request.url!;
                              if (![
                                "http",
                                "https",
                                "file",
                                "chrome",
                                "safari",
                                "data",
                                "javascript",
                                "about"
                              ].contains(uri.scheme)) {}
                              return NavigationActionPolicy.ALLOW;
                            },
                            onLoadStart: (controller, url) async {
                              // if (url ==
                              //     "https://dipmenu-website-uat.demomywebapp.com/paymentreceipt") {
                              //   //close the webview
                              //   print('welcome to');
                              // }

                              // print(
                              //     'loading values ---->${controller.android
                              //         .toString()}');
                            },
                            onLoadStop: (controller, url) async {

                             //  final copyBackForwardList =
                             //  await googlePaymentController.webViewController?.getCopyBackForwardList();
                             //  final userAgent =copyBackForwardList!.list!.first.title;
                             //  if (userAgent != null) {
                             //    setState(() {
                             //      // Extracting the Chromium version from the user agent
                             //      final versionMatch =
                             //      RegExp(r'Chrome/([\d.]+)').firstMatch(userAgent);
                             //      if (versionMatch != null) {
                             // print( versionMatch.group(1));
                             //      }
                             //    });
                             //  }
                              // print(url);
                              googlePaymentController
                                  .viewOfPage(url.toString());
                            },
                            onLoadError:
                                (controller, url, int values, String urlValues) {
                              // print('-------------------');
                              // print(Url);
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              // print('message ---->${consoleMessage.message}');
                              // print(consoleMessage);
                            },
                          ),
                        )));
          },
        ),
      ),
    );
  }
}

/*FlWebView(
                  load: LoadUrlRequest(googlePaymentController
                      .paymentUrl),
                  progressBar: FlProgressBar(color: Colors.red),
                  webSettings: WebSettings(),
                  delegate: FlWebViewDelegate(onPageStarted:
                      (FlWebViewController controller, String url) {
                    log('onPageStarted : $url');
                  },
                      onPageFinished: (FlWebViewController controller, String url) {
                        log('onPageFinished : $url');
                      },
                      onProgress: (FlWebViewController controller, int progress) {
                        log('onProgress ：$progress');
                      },
                      onSizeChanged:
                          (FlWebViewController controller, WebViewSize webViewSize) {
                        log('onSizeChanged : ${webViewSize.frameSize} --- ${webViewSize.contentSize}');
                      },
                      onScrollChanged: (FlWebViewController controller,
                          WebViewSize webViewSize,
                          Offset offset,
                          ScrollPositioned positioned) {
                        log('onScrollChanged : ${webViewSize.frameSize} --- ${webViewSize.contentSize} --- $offset --- $positioned');
                      },
                      onNavigationRequest:
                          (FlWebViewController controller, NavigationRequest request) {
                        log('onNavigationRequest : url=${request.url} --- isForMainFrame=${request.isForMainFrame}');
                        return true;
                      },
                      onUrlChanged: (FlWebViewController controller, String url) {
                        log('onUrlChanged : $url');
                      }),
                  onWebViewCreated: (FlWebViewController controller) async {
                    String userAgentString = 'userAgentString';
                    final value = await controller.getNavigatorUserAgent();
                    log('navigator.userAgent :  $value');
                    userAgentString = '$value = $userAgentString';
                    final userAgent = await controller.setUserAgent(userAgentString);
                    log('set userAgent:  $userAgent');
                    controller.getWebViewSize();
                    // 10.seconds.delayed(() {
                    //
                    // });
                  });*/

// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// import '../../logic/controller/google_payment_integration_controller.dart';
//
// class MyInAppBrowser extends InAppBrowser {
//   @override
//   onLoadStart(url) async {
//     print("\n\nStarted $url\n\n");
//     debugPrint('---------------------------------------');
//     debugPrint('$url');
//   }
//
//   @override
//   onLoadStop(url) async {
//     print("\n\nStopped $url\n\n");
//   }
//
//   @override
//   onLoadError(url, int code, String message) {
//     print("\n\nCan't load $url.. Error: $message\n\n");
//   }
//
//   @override
//   onExit() {
//     print("\n\nBrowser closed!\n\n");
//   }
// }
//
// MyInAppBrowser inAppBrowserFallback = new MyInAppBrowser();
//
// class MyChromeSafariBrowser extends ChromeSafariBrowser {
//   MyChromeSafariBrowser(inAppBrowserFallback) : super();
//
//   @override
//   void onOpened() {
//     print("ChromeSafari browser opened");
//   }
//
//   @override
//   void onCompletedInitialLoad() {
//     print("ChromeSafari browser loaded");
//   }
//
//   @override
//   void onClosed() {
//     print("ChromeSafari browser closed");
//   }
//
//   void onServiceConnected() async {
//     // Validate the session as the same origin to allow cross origin headers.
//   }
//
//   void onRelationshipValidationResult(
//       Uri? requestedOrigin, bool result) async {}
// }
//
// class GooglePaymentScreen extends StatefulWidget {
//   final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());
//
//   @override
//   _MyAppState createState() => new _MyAppState();
// }
//
// class _MyAppState extends State<GooglePaymentScreen> {
//   ChromeSafariBrowser? browser;
//   InAppWebViewController? webViewController;
//   String currentUrl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     browser = ChromeSafariBrowser();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   void openWebPage() async {
//     await browser?.open(
//       url: Uri.parse(googlePaymentController.paymentUrl!),
//       options: ChromeSafariBrowserClassOptions(
//         android: AndroidChromeCustomTabsOptions(addDefaultShareMenuItem: false),
//         ios: IOSSafariOptions(barCollapsingEnabled: true),
//       ),
//     );
//   }
//
//   viewingPage() async {
//     await widget.browser.open(
//         url: Uri.parse(googlePaymentController.paymentUrl!),
//         options: ChromeSafariBrowserClassOptions(
//             android: AndroidChromeCustomTabsOptions(
//                 enableUrlBarHiding: true,
//                 showTitle: false,
//                 noHistory: false,
//                 toolbarBackgroundColor: Colors.white,
//                 addDefaultShareMenuItem: false),
//             ios: IOSSafariOptions(
//                 barCollapsingEnabled: true, entersReaderIfAvailable: true)));
//   }
//
//   final googlePaymentController =
//       Get.find<GooglePaymentIntegrationController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InAppWebView(
//         onWebViewCreated: (controller) {
//           webViewController = controller;
//         },
//         initialUrlRequest:
//             URLRequest(url: Uri.parse(googlePaymentController.paymentUrl!)),
//         shouldOverrideUrlLoading: (controller, navigationAction) async {
//           final url = navigationAction.request.url;
//           setState(() {
//             currentUrl = url.toString();
//           });
//           return NavigationActionPolicy.ALLOW;
//         },
//       ),
//     );
//   }
// }
//
// class welcome {
//   String? iosvalues = 'onChromeSafariBrowserItemActionPerform';
// }
