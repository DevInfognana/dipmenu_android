import 'dart:io';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../presentation/routes/routes.dart';
class NotificationService {
  NotificationService();
  final text = Platform.isIOS;
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('drawable/ic_launcher');

    // const IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //     requestSoundPermission: true,
    //     requestBadgePermission: true,
    //     requestAlertPermission: true);
    //instead of the above commented deprecated code
    const DarwinInitializationSettings initializationSettingsIOS =  // Changed from IOSInitializationSettings
    DarwinInitializationSettings(  // Changed from IOSInitializationSettings
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true);

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );




    // await _localNotifications.initialize(
    //   initializationSettings,
    //   onSelectNotification: selectNotification,
    // );
    //instead of the above commented deprecated code
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {  // Changed from onSelectNotification
        selectNotification(notificationResponse.payload);
      },
    );
  }
  //
  // @pragma('vm:entry-point')
  // void notificationTapBackground() {
  //
  // }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
      'DIP MENU id',
      'DIP Menu name',
      groupKey: 'com.example.dip_menu',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      audioAttributesUsage: AudioAttributesUsage.notification,
      // sound: RawResourceAndroidNotificationSound('notification_sound'),
      enableVibration: true,
      // color: Color(0xff2196f3),
      // color: Color(0xff000000),
    );

    // IOSNotificationDetails iosNotificationDetails = const IOSNotificationDetails(
    //     threadIdentifier: "thread1",
    //     attachments: <IOSNotificationAttachment>[]);
    //instead of the above commented deprecated code
    DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(  // Changed from IOSNotificationDetails
        threadIdentifier: "thread1",
        attachments: <DarwinNotificationAttachment>[]);

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      // behaviorSubject.add(details.payload!);
      //instead of the above commented deprecated code
      behaviorSubject.add(details.notificationResponse?.payload ?? '');  // Changed from details.payload!
    }



    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }


  Future<void> showScheduledLocalNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,  // Added required parameter
      // uiLocalNotificationDateInterpretation:
      // UILocalNotificationDateInterpretation.absoluteTime,
      // androidAllowWhileIdle: true,
      // androidAllowWhileIdle: true,
    );
  }

  Future<void> showdLocalNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: 'welcome'
    );
  }



  void onDidReceiveLocalNotification(
      int id,
      String? title,
      String? body,
      String? payload,
      ) {

  }

  void selectNotification(String? payload) {
    Map notificationValues={"notification": 'show'};
    Get.offAndToNamed(Routes.mainScreen,arguments:notificationValues );
  }

}

