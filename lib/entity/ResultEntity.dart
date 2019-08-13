/// 封装网络请求结果
class ResultEntity<T> {
  int code;
  String message;
  T data;

  bool success() {
    return code == 1;
  }
}