import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

const int PERMISSION_DENIED = 0;
const int PERMISSION_GRANTED = 1;
const int PERMISSION_EXIST = 2;

Future<int> checkPermission(BuildContext context) async {
  if (Theme.of(context).platform == TargetPlatform.android) {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.storage].request();
      if (statuses[Permission.storage] == PermissionStatus.granted) {
        return PERMISSION_GRANTED;
      } else {
        return PERMISSION_DENIED;
      }
    } else {
      return PERMISSION_EXIST;
    }
  } else if (Theme.of(context).platform == TargetPlatform.iOS) {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses =
      await [Permission.photos].request();
      if (statuses[Permission.photos] == PermissionStatus.granted) {
        return PERMISSION_GRANTED;
      } else {
        return PERMISSION_DENIED;
      }
    } else {
      return PERMISSION_EXIST;
    }
  }
  return PERMISSION_EXIST;
}

Future<bool> openSettings() async {
  bool isOpened = await openAppSettings();
  return isOpened;
}
