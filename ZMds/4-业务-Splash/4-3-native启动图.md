# 4.3 native 启动图

## 参考

- https://pub.dev/packages/flutter_native_splash
- https://pub.dev/packages/flutter_native_splash#android-12-support
- https://developer.android.com/about/versions/12/features/splash-screen

## 步骤

### 安装依赖包

```sh
flutter pub add flutter_native_splash -d
```

或者

pubspec.yaml

```yaml
dev_dependencies:
	...
	
  # 启动图
  flutter_native_splash: ^2.4.2
```

[flutter_native_splash](https://pub.dev/packages/flutter_native_splash) 插件放在开发依赖，这样就不用打包到发布版本中，减少 APP 尺寸。

### android 11 及以下

pubspec.yaml

```yaml
flutter_native_splash:
	background_image: "assets/launcher/background.png"
```

生成启动屏

```sh
dart run flutter_native_splash:create
```

```sh
Building package executable...
Built flutter_native_splash:create.
[Android] Creating default android12splash images
[Android] Creating dark mode android12splash images
[Android] Updating launch background(s) with splash image path...
[Android]  - android/app/src/main/res/drawable/launch_background.xml
[Android]  - android/app/src/main/res/drawable-v21/launch_background.xml
[Android] Updating styles...
[Android]  - android/app/src/main/res/values-v31/styles.xml
[Android]  - android/app/src/main/res/values-night-v31/styles.xml
[Android]  - android/app/src/main/res/values/styles.xml
[Android]  - android/app/src/main/res/values-night/styles.xml
[iOS] Updating ios/Runner/Info.plist for status bar hidden/visible
```

也可以删除

```sh
dart run flutter_native_splash:remove
```

```sh
Building package executable...
Built flutter_native_splash:remove.
Restoring Flutter's default native splash screen...
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Deleting android12splash.png
[Android] Updating launch background(s) with splash image path...
[Android]  - android/app/src/main/res/drawable/launch_background.xml
[Android]  - android/app/src/main/res/drawable-night/launch_background.xml
[Android]  - android/app/src/main/res/drawable-v21/launch_background.xml
[Android]  - android/app/src/main/res/drawable-night-v21/launch_background.xml
[Android] Updating styles...
[Android]  - android/app/src/main/res/values-v31/styles.xml
[Android]  - android/app/src/main/res/values-night-v31/styles.xml
[Android]  - android/app/src/main/res/values/styles.xml
[Android]  - android/app/src/main/res/values-night/styles.xml
[iOS] Updating ios/Runner/Info.plist for status bar hidden/visible
```

如果你目标机器 android 11 这样，就会有一张图片被拉伸的情况占满屏幕。

![android 11 启动屏](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/10/0ee53ffedd3b58465dd23d8cf2b25333.png)

### ios 启动图

pubspec.yaml

```yaml
flutter_native_splash:
  background_image_ios: "assets/launcher/background.png"
```

> 记得 `dart run flutter_native_splash:create`， 每次修改都需要重新创建，之后将不再重复说。

![IOS 启动图](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/10/14c1e8a632ced26eafd63a2628f735c9.png)

### android 12 图标启动图

android 12 之后启动方式改成图标启动，下面是文章说明。

https://pub.dev/packages/flutter_native_splash#android-12-support

https://developer.android.com/develop/ui/views/launch/splash-screen?hl=zh-cn

![Android 12+ Support](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/10/5b90e95510e4d5ec3ca4dd08ec54097f.png)

pubspec.yaml

```yaml
flutter_native_splash:
  color_android: "#f6eee4"
  android_12:
    image: "assets/launcher/android12.png"
    icon_background_color: "#324ea1"
```

分别设置了，启动视图背景、图标、图标背景。

![android 12 图标启动图](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/10/afb1c098e54959f4982e1df7a165cc23.png)



### 同时支持 android 11 及以下, 12 以上，IOS

pubspec.yaml

```yaml
flutter_native_splash:
  background_image_android: "assets/launcher/background.png"
  background_image_ios: "assets/launcher/background.png"
  android_12:
    image: "assets/launcher/android12.png"
    icon_background_color: "#324ea1"
```

这样配置后的结果如下：

- android 11 及以下满屏拉伸启动图
- ios 满屏拉伸启动图
- android 12 图标带图标背景启动图

### 手动释放启动图

这种方式不推荐，两个理由：

- 增加发布包 app 的尺寸
- 容易出错，如忘记 `remove()` 会卡在启动图。

### 配置清单

```yaml
flutter_native_splash:
  # 这个包生成原生代码，以自定义 Flutter 的默认白色启动屏幕
  # 通过背景颜色和启动图像进行定制。
  # 自定义下面的参数，并在终端中运行以下命令：
  # dart run flutter_native_splash:create
  # 要恢复 Flutter 的默认白色启动屏幕，请在终端中运行以下命令：
  # dart run flutter_native_splash:remove

  # 重要说明：这些参数不影响 Android 12 及更高版本的配置，
  # 因为这些版本的启动屏幕处理方式与之前的 Android 版本不同。
  # Android 12 及更高版本必须在下面的 android_12 部分中进行特定配置。

  # color 或 background_image 是唯一的必需参数。使用 color 设置启动屏幕的背景
  # 为纯色。使用 background_image 设置启动屏幕的背景为 PNG 图片。
  # 这对于渐变效果很有用。图片将被拉伸到应用的大小。只能使用一个参数，
  # color 和 background_image 不能同时设置。
  color: "#42a5f5"
  #background_image: "assets/background.png"

  # 可选参数如下。要启用某个参数，请通过删除前面的 # 字符来取消注释该行。

  # image 参数允许你指定用于启动屏幕的图片。必须是 PNG 文件，且应为 4x 像素密度调整大小。
  #image: assets/splash.png

  # branding 属性允许你指定用于启动屏幕的品牌图片。
  # 必须是 PNG 文件。支持 Android、iOS 和 Web。对于 Android 12，
  # 请参见下面的 Android 12 部分。
  #branding: assets/dart.png

  # 要将品牌图像定位在屏幕底部，可以使用 bottom、bottomRight 和 bottomLeft。
  # 如果未指定或指定其他内容，默认值为 bottom。
  #branding_mode: bottom
  
  # 设置品牌图像与屏幕底部的间距。默认值为 0。
  # branding_bottom_padding: 24

  # color_dark、background_image_dark、image_dark 和 branding_dark 是在设备处于暗模式时设置的参数。
  # 如果未指定，将使用上述参数。如果指定了 image_dark 参数，则必须指定 color_dark 或
  # background_image_dark。color_dark 和 background_image_dark 不能同时设置。
  #color_dark: "#042a49"
  #background_image_dark: "assets/dark-background.png"
  #image_dark: assets/splash-invert.png
  #branding_dark: assets/dart_dark.png

  # 从 Android 12 开始，启动屏幕的处理方式与之前的版本不同。
  # 请访问 https://developer.android.com/guide/topics/ui/splash-screen
  # 以下是 Android 12+ 的特定参数。
  android_12:
    # image 参数设置启动屏幕图标图片。如果未指定该参数，
    # 将使用应用的启动图标。
    # 请注意，启动屏幕将裁剪为屏幕中央的圆形。
    # 带图标背景的应用图标：应为 960×960 像素，并适合于直径为 640 像素的圆形。
    # 无图标背景的应用图标：应为 1152×1152 像素，并适合于直径为 768 像素的圆形。
    #image: assets/android12splash.png

    # 启动屏幕背景颜色。
    #color: "#42a5f5"

    # 应用图标背景颜色。
    #icon_background_color: "#111111"

    # branding 属性允许你指定用于启动屏幕的品牌图片。
    #branding: assets/dart.png

    # image_dark、color_dark、icon_background_color_dark 和 branding_dark 设置在设备处于暗模式时
    # 应用的值。如果未指定，将使用上述参数。
    #image_dark: assets/android12splash-invert.png
    #color_dark: "#042a49"
    #icon_background_color_dark: "#eeeeee"

  # android、ios 和 web 参数可用于禁用在给定平台上生成启动屏幕。
  #android: false
  #ios: false
  #web: false

  # 可以使用以下参数指定平台特定的图像，这些参数将覆盖相应的参数。
  # 你可以指定所有、选定或不指定这些参数：
  #color_android: "#42a5f5"
  #color_dark_android: "#042a49"
  #color_ios: "#42a5f5"
  #color_dark_ios: "#042a49"
  #color_web: "#42a5f5"
  #color_dark_web: "#042a49"
  #image_android: assets/splash-android.png
  #image_dark_android: assets/splash-invert-android.png
  #image_ios: assets/splash-ios.png
  #image_dark_ios: assets/splash-invert-ios.png
  #image_web: assets/splash-web.gif
  #image_dark_web: assets/splash-invert-web.gif
  #background_image_android: "assets/background-android.png"
  #background_image_dark_android: "assets/dark-background-android.png"
  #background_image_ios: "assets/background-ios.png"
  #background_image_dark_ios: "assets/dark-background-ios.png"
  #background_image_web: "assets/background-web.png"
  #background_image_dark_web: "assets/dark-background-web.png"
  #branding_android: assets/brand-android.png
  #branding_bottom_padding_android: 24
  #branding_dark_android: assets/dart_dark-android.png
  #branding_ios: assets/brand-ios.png
  #branding_bottom_padding_ios: 24
  #branding_dark_ios: assets/dart_dark-ios.png
  #branding_web: assets/brand-web.gif
  #branding_dark_web: assets/dart_dark-web.gif

  # 启动图像的位置可以使用 android_gravity、ios_content_mode 和
  # web_image_mode 参数进行设置。所有默认值为中心。
  #
  # android_gravity 可以是以下 Android Gravity 的其中之一（见
  # https://developer.android.com/reference/android/view/Gravity）：bottom、center、
  # center_horizontal、center_vertical、clip_horizontal、clip_vertical、end、fill、fill_horizontal、
  # fill_vertical、left、right、start 或 top。
  #android_gravity: center
  #
  # ios_content_mode 可以是以下 iOS UIView.ContentMode 的其中之一（见
  # https://developer.apple.com/documentation/uikit/uiview/contentmode）：scaleToFill、
  # scaleAspectFit、scaleAspectFill、center、top、bottom、left、right、topLeft、topRight、
  # bottomLeft 或 bottomRight。
  #ios_content_mode: center
  #
  # web_image_mode 可以是以下模式之一：center、contain、stretch 和 cover。
  #web_image_mode: center

  # 可以使用 android_screen_orientation 参数设置 Android 的屏幕方向。
  # 有效参数可以在这里找到：
  # https://developer.android.com/guide/topics/manifest/activity-element#screen
  #android_screen_orientation: sensorLandscape

  # 要隐藏通知栏，请使用 fullscreen 参数。由于 Web
  # 没有通知栏，因此该参数无效。默认值为 false。
  # 注意：与 Android 不同，iOS 在应用加载时不会自动显示通知栏。
  #       要显示通知栏，请在你的 Flutter 应用中添加以下代码：
  #       WidgetsFlutterBinding.ensureInitialized();
  #       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top], );
  #fullscreen: true

  # 如果你更改了 info.plist 文件的名称，可以使用 info_plist_files 参数指定文件名。
  # 仅删除下面三行中的 # 字符，不要删除任何空格：
  #info_plist_files:
  #  - 'ios/Runner/Info-Debug.plist'
  #  - 'ios/Runner/Info-Release.plist'
```

### WOO 项目中的配置

```yaml
# 启动图适配 android 11 及以下, 12 以上，IOS
flutter_native_splash:
  web: false
  color_android: "#ffffff"
  # background_image_android: "assets/launcher/background.png"
  background_image_ios: "assets/launcher/background.png"
  # image_ios: "assets/launcher/android.png"
  android_12:
    image: "assets/launcher/android12.png"
    # icon_background_color: "#324ea1"
```

我这样配置 android 不管什么版本都正常显示。


> 提交代码到 git

```sh
git add .
git commit -m "4.3 native 启动图"
```

