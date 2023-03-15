import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationService {
  static Future<void> initialize() async {
    await OneSignal.shared.setAppId('<ONESIGNAL_APP_ID>');

    await OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Handle notification open here
    });

    await OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      // Handle in app message click here
    });
  }

  static Future<void> subscribeToTopic(String topic) async {
    await OneSignal.shared.sendTag(topic, 'true');
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await OneSignal.shared.deleteTag(topic);
  }

  static Future<void> sendNotification(String title, String body,
      {String? imageUrl, Map<String, dynamic>? data}) async {
    final notification = OSCreateNotification(
      playerIds: null,
      content: body,
      heading: title,
      iosAttachments: imageUrl != null
          ? {'id1': imageUrl}
          : null, // iOS requires a unique ID for each attachment
      data: data,
    );
    await OneSignal.shared.postNotification(notification);
  }
}
