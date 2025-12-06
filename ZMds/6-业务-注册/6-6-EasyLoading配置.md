# 6.6 EasyLoading 配置

## 目标

采用 flutter_easyloading 组件实现浮动提示组件。

## 实现步骤：

---

### 第 1 步：下载插件 flutter_easyloading

https://pub.dev/packages/flutter_easyloading

```bash
flutter pub add flutter_easyloading
```

### 第 2 步：loading 工具类

lib/common/utils/loading.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// 提示框
class Loading {
  static const int _milliseconds = 500; // 提示 延迟毫秒, 提示体验 秒关太快
  static const int _dismissMilliseconds = 2000; // dismiss 延迟毫秒

  Loading() {
    EasyLoading.instance
      ..displayDuration =
          const Duration(milliseconds: _dismissMilliseconds) // 关闭延迟
      ..indicatorType = EasyLoadingIndicatorType.ring // 指示器类型
      ..loadingStyle = EasyLoadingStyle.custom // loading样式 自定义
      ..indicatorSize = 35.0 // 指示器大小
      ..lineWidth = 2 // 进度条宽度
      ..radius = 10.0 // 圆角
      ..progressColor = Colors.white // 进度条颜色
      ..backgroundColor = Colors.black.withOpacity(0.7) // 背景颜色
      ..indicatorColor = Colors.white // 指示器颜色
      ..textColor = Colors.white // 文字颜色
      ..maskColor = Colors.black.withOpacity(0.6) // 遮罩颜色
      ..userInteractions = true // 用户交互
      ..dismissOnTap = false; // 点击关闭
  }

  // 显示
  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false; // 屏蔽交互操作
    EasyLoading.show(status: text ?? 'Loading...');
  }

  // 错误
  static void error([String? text]) {
    Future.delayed(
      const Duration(milliseconds: _milliseconds),
      () => EasyLoading.showError(text ?? 'Error'),
    );
  }

  // 成功
  static void success([String? text]) {
    Future.delayed(
      const Duration(milliseconds: _milliseconds),
      () => EasyLoading.showSuccess(text ?? 'Success'),
    );
  }

  // toast
  static void toast(String text) {
    EasyLoading.showToast(text);
  }

  // 关闭
  static Future<void> dismiss() async {
    await Future.delayed(
      const Duration(milliseconds: _dismissMilliseconds),
      () {
        EasyLoading.instance.userInteractions = true; // 恢复交互操作
        EasyLoading.dismiss();
      },
    );
  }
}
```

### 第 3 步：main build

lib/main.dart

```dart
      // builder
      builder: (context, widget) {
        widget =
            EasyLoading.init()(context, widget); // EasyLoading 初始化

        // 不随系统字体缩放比例
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: widget,
        );
      },
```

> 这是有多个要初始的情况

### 最后：global 全局初始

lib/global.dart

```dart
class Global {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 工具类
    await Storage().init();
    Loading();
```

> 提交代码到 git

```sh
git add .
git commit -m "6.6 EasyLoading 配置"
```

