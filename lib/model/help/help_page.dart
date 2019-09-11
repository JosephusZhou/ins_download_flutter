import 'package:flutter/material.dart';

// 帮助页
class HelpPage extends StatelessWidget {
  static void start(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("帮助"),
      ),
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}
