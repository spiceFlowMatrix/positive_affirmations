import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app/consts.dart';
import 'package:repository/repository.dart';

/** Reference for working solution for notifications service:
 * - Blog post: https://medium.com/flutter-community/local-notifications-in-flutter-746eb1d606c6
 * - Repo: https://github.com/TomerPacific/BirthdayCalendar
 **/
class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String channelId = 'pa_let';
  static const String channelName = 'Positive Affirmations Letters';
  static const String channelDescription =
      'For when Positive Affirmations generates timed letters for the user';

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint(payload);
    }
  }

  void showLetterNotification(Letter letter, String notificationMessage) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      letter.hashCode,
      applicationName,
      notificationMessage,
      platformChannelSpecifics,
      payload: letter.fieldValues.toString(),
    );
  }
}
