import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as time_zone_data;
import 'package:timezone/timezone.dart' as time_zone;
import 'package:tyrios_news_app/utilities/common_exports.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init({bool scheduled = false}) async {
    time_zone_data.initializeTimeZones();
    const InitializationSettings initSettings = InitializationSettings(
      android: AndroidInitializationSettings('mipmap/logo'),
      iOS: DarwinInitializationSettings(),
    );
    await _notifications.initialize(initSettings);
  }

  static void showNotification(NotificationMessage message) =>
      _notifications.show(
        message.id,
        message.title,
        message.body,
        _notificationDetails(),
        payload: message.payload,
      );

  static Future<void> showScheduleNotification(
    NotificationMessage message,
  ) async =>
      _notifications.periodicallyShow(
        message.id,
        message.title,
        message.body,
        RepeatInterval.everyMinute,
        _notificationDetails(),
      );

  static void showZoneScheduleNotification({
    required NotificationMessage message,
    required DateTime scheduleDate,
  }) =>
      _notifications.zonedSchedule(
        message.id,
        message.title,
        message.body,
        time_zone.TZDateTime.from(scheduleDate, time_zone.local),
        _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  static NotificationDetails _notificationDetails() =>
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          channelDescription: 'channelDescription',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

  static Future<void> stopNotification() async => _notifications.cancelAll();
}
