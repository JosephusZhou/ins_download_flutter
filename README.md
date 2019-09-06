# ins_download_flutter

Download images and videos from Instagram.

项目 InsDownload 的 Flutter 版本。

使用 Flutter 开发，Android、iOS 均可使用。

### 2019-09-04 Note

通过本次 Flutter 尝试性开发，可以确定一点，~~玩玩可以，就别商业性使用了，除非贵司的开发人员真的很闲，或者贵司很有人力财力去投入~~

Flutter 目前对于 Android、iOS 平台来讲，他只是一个 UI 开发包，或者说是一个 UI SDK，可以让你绘制 UI 界面，涉及原生的功能该写的原生平台代码一行都不会少。

目前国内的谷吹真的很恶心(~~我很讨厌谷吹
stormzhang~~)，动不动就是谷歌出的就是好东西，一会吹爆 Kotlin 啦，一会动不动就是会Flutter 就可以一人搞定 Android 和 iOS 了之类的话。真的不可能，别跟我说有很多第三方库，商业项目中产品需求永远都需要二次开发，该涉及的原生开发还是需要的。~~我也是写过了一个完整项目才来吐槽的~~。

怎么说呢，作为一个 Android 开发，写起界面来需要一点时间熟悉，之后就是各种封装UI组件，确实声明式界面有很多优点，数据绑定等等就不说了。

但是其实难点还是在于和原生的各种交互吧，比如涉及 iOS 的权限声明，用了 `permission_handler`, 网上教程包括第三方库的 wiki 都没有涉及到 iOS 需要在 `info.plist` 中声明权限，还是去请教了 iOS 的开发同事才了解的。从这一点可以看出，大部分都是 Android 开发人员在玩 Flutter。

开发出第一个能下载图片的版本后，开始对Android 的打包编译进行整理，包括 apk 签名啦、apk 输出重命名等等，改完 `build.gradle`
就是各种报错，比如下面的，这玩意需要走的路还很长，玩玩就好。

- `Finished with error: Gradle build failed to produce an Android
  package.`
- `[ERROR:flutter/shell/platform/android/platform_view_android_jni.cc(719)]
  Could not locate FlutterCallbackInformation class`

最后说说这玩意目前能干嘛吧~

- 纯 Flutter 项目，也就那些浏览性质的比如新闻帖子 App 吧，最好不涉及原生功能交互
- 原生 App 的活动页面，比如一些活动宣传页，可以采用 Flutter 写，Android、iOS 同时写不同的 Flutter 界面，共享使用，加快开发速度，两端 UI 一致还原，涉及小量原生功能约定好 `channel` 的消息通信，各自实现原生功能即可。

最后的最后，该踩的坑一个都不会少，开发效率不高，毕竟我一个 Android 开发写起 iOS
原生来还得现学~

最后的最后的最后，编译 apk 成功了，ipa 就暂时不管了，毕竟我没有 apple 开发者账号，原生apk 是 2MB，Flutter 的 apk 是 14MB，比起一开始动不动几十 MB 好多了，还是有点未来的，毕竟这 UI 还是很不错的，就是希望赶紧把 github 上那堆 issues 解决了吧，太多问题了~

### Features

- 通过帖子链接获取帖子的图片和视频
- 下载帖子图片

### ToDo

* 自动获取剪贴板链接
* 列表的视频 item 添加图标，和图片 item 区分开
* 下载并保存视频
* 添加列表项图片占位图片
* 添加列表项图片加载过渡效果
* 添加启动页
* 分离页面代码，解耦功能

### Build Info

- 在`android`目录下创建`keystore`目录，存放签名密钥
- 在`android`目录下创建`keystore.properties`文件，内容示例如下：

```
STORE_FILE=../keystore/key
STORE_PASSWORD=######
kEY_ALIAS=@@@@@
KEY_PASSWORD=######
```