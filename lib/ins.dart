import 'dart:convert';
import 'package:http/http.dart';
import 'entity/ResultEntity.dart';
import 'entity/InsMediaEntity.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

/// Instagram 相关

// 请求 Ins 帖子
Future<ResultEntity<List<InsMediaEntity>>> requestData(String url) async {
  var result = ResultEntity<List<InsMediaEntity>>();
  result.code = -1;
  var response = await get(url);
  if (response.statusCode == 200) {
    result.code = 1;
    result.data = await parseInsPost(response.body);
  } else {
    result.code = response.statusCode;
    result.message = "Request Error, code: " + response.statusCode.toString();
  }
  return result;
}

// 解析 Ins 帖子，解析耗时，封装成异步
Future<List<InsMediaEntity>> parseInsPost(String html) async {
  var list = List<InsMediaEntity>();
  Document doc = parse(html);
  var items = doc.querySelectorAll('script[type="text/javascript"]');
  for (var element in items) {
    if (element.text.contains("window._sharedData")) {
      var jsonStr = element.text.substring(21, element.text.length - 1);
      Map<String, dynamic> map = json.decode(jsonStr);
      Map<String, dynamic> mediaMap =
          map['entry_data']['PostPage'][0]['graphql']['shortcode_media'];
      List<dynamic> displayResources = mediaMap['display_resources'];
      var displayMediaEntity = parseSingleMedia(displayResources);
      // 视频
      if (mediaMap['is_video']) {
        var insMediaEntity = InsMediaEntity();
        insMediaEntity.isVideo = true;
        insMediaEntity.videoUrl = mediaMap['video_url'];
        insMediaEntity.thumbnailUrl = displayMediaEntity.thumbnailUrl;
        list.add(insMediaEntity);
      }
      // 多张图片
      if (mediaMap.containsKey('edge_sidecar_to_children')) {
        for (var edgeItem in mediaMap['edge_sidecar_to_children']['edges']) {
          list.add(parseSingleMedia(edgeItem['node']['display_resources']));
        }
      }
      // 单张图片
      else {
        list.add(displayMediaEntity);
      }
      break;
    }
  }
  return list;
}

// 解析单个媒体
InsMediaEntity parseSingleMedia(List<dynamic> resources) {
  var entity = InsMediaEntity();
  entity.isVideo = false;
  var minWidth = -1;
  var maxWidth = -1;
  for (var map in resources) {
    if (minWidth == -1 || minWidth > map['config_width']) {
      minWidth = map['config_width'];
      entity.thumbnailUrl = map['src'];
    }
    if (maxWidth == -1 || maxWidth < map['config_width']) {
      maxWidth = map['config_width'];
      entity.imageUrl = map['src'];
    }
  }
  return entity;
}
