/// 存储 ins 数据的实体类
class InsMediaEntity {

  static const int NO_DOWNLOAD = 0;
  static const int DOWNLOADING = 1;
  static const int DOWNLOADED = 2;

  String thumbnailUrl;
  bool isVideo;
  String videoUrl;
  String imageUrl;

  int downloadStatus = NO_DOWNLOAD;
  String downloadPath;
}