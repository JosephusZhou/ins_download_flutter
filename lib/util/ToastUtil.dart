
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

void toast(String message, BuildContext context, {int duration = 0}) {
  Toast.show(message,
    context,
    duration: duration == 0 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: Toast.CENTER,
    backgroundColor: const Color(0x99000000),
    backgroundRadius: 4,
  );
}