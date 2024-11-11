import 'package:permission_handler/permission_handler.dart';

class PermissionsMethods {
  askNotificationPermission() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }
}
