import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationService {
  Future<void> initialize() async {
    await OneSignal.shared.init(
      'YOUR_ONESIGNAL_APP_ID',
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: true,
      },
    );
  }

  Future<void> register() async {
    await OneSignal.shared.promptUserForPushNotificationPermission();
    final status = await OneSignal.shared.getPermissionSubscriptionState();
    final playerId = status.subscriptionStatus.userId;
    // Save playerId to server or local storage
  }

  Future<void> unregister() async {
    await OneSignal.shared.setSubscription(false);
  }
}
