import 'package:flutter/material.dart';

// 关于页
class AboutPage extends StatelessWidget {
  static void start(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
