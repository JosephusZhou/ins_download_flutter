
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

void toast(String message, BuildContext context) {
  Toast.show(message,
    context,
    duration: Toast.LENGTH_SHORT,
    gravity: Toast.CENTER,
    backgroundColor: const Color(0x99000000),
    backgroundRadius: 4,
  );
}