import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

const int PERMISSION_DENIED = 0;
const int PERMISSION_GRANTED = 1;
const int PERMISSION_EXIST = 2;

Future<int> checkPermission(BuildContext context) async {
  if (Theme.of(context).platform == TargetPlatform.android) {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
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
