import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ins_download_flutter/constants.dart';

import 'behavior/NoRippleBehavior.dart';
import 'model/main/main_page.dart';

void main() {
  runApp(MainApp());
  // 状态栏透明
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

// App
class MainApp extends StatelessWidget {
  final String title = 'Ins';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoRippleBehavior(),
          child: child,
        );
      },
      title: title,
      theme: ThemeData(
        primarySwatch: Constants.pColor,
      ),
      home: MainPage(title: title),
    );
  }
}


