import 'dart:io';
import 'package:toast/toast.dart';

import 'ins.dart';
import 'entity/InsMediaEntity.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: title),
    );
  }
}

// 主页
class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

// 主页逻辑
class _MainPageState extends State<MainPage> {
  final _textFieldController = TextEditingController();
  bool _loading = false;
  List<InsMediaEntity> _mediaList = List<InsMediaEntity>();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  // 重置输入
  void _resetTextField() {
    _textFieldController.text = '';
  }

  // 获取图片视频
  void _getInsData() {
    String text = _textFieldController.text;
    if (text.isEmpty || !text.contains("instagram.com")) return;
    setState(() {
      _loading = true;
    });
    requestData(text).then((result) {
      setState(() {
        _loading = false;
      });
      if (result.success()) {
        setState(() {
          _mediaList = result.data;
        });
      } else {
        Toast.show(result.message, context);
      }
    }, onError: (e) {
      setState(() {
        _loading = false;
      });
      Toast.show(e.toString(), context);
      print(e);
    });
  }

  // 帖子对应的媒体列表布局
  Widget _mediaListLayout() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _mediaListItemLayout(index);
        },
        itemCount: _mediaList.length,
      ),
    );
  }

  // 列表单项布局
  Widget _mediaListItemLayout(int index) {
    var entity = _mediaList[index];
    return Container(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image(
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    image: NetworkImage(entity.thumbnailUrl),
                    alignment: Alignment.topLeft,
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: null,
                        child: Text("下载"),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(4),
              ),
              Text(
                "111111111_" + index.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 默认布局层
  Widget _defaultLayout() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: TextField(
              controller: _textFieldController,
              maxLines: 3,
              onSubmitted: null,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  hintText: "请输入 Instagram 帖子链接"),
            ),
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            margin: EdgeInsets.only(top: 0),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Padding(padding: EdgeInsets.all(4)),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 44,
                  child: RaisedButton(
                    child: Text("获取图片视频"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: _getInsData,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(16)),
              Expanded(
                child: Container(
                  height: 44,
                  child: RaisedButton(
                    child: Text("重置输入"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: _resetTextField,
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(4)),
          _mediaListLayout(),
        ],
      ),
    );
  }

  // 加载遮罩层
  Widget _loadingLayout() {
    return Offstage(
      offstage: !_loading,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  // 整体布局
  Widget _bodyLayout() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _defaultLayout(),
          _loadingLayout(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _textFieldController.text =
        "https://www.instagram.com/p/B0TLbTrlP1b/?igshid=1h9qggxiaxjz0";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _bodyLayout(),
    );
  }
}
