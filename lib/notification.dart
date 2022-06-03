import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
final notifications = FlutterLocalNotificationsPlugin();


//1. 앱로드시 실행할 기본설정
initNotification() async {

  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting
  );
  await notifications.initialize(
    initializationSettings,
    //알림 누를때 함수실행하고 싶으면
    //onSelectNotification: 함수명추가
  );
}


//2. 이 함수 원하는 곳에서 실행하면 알림 뜸
showNotification() async {
  tz.initializeTimeZones();
  var androidDetails = AndroidNotificationDetails(
    'ID',
    'ds',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.zonedSchedule(
      2,
      'Plant-app',
      '물주실 시간입니다',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime
  );
}