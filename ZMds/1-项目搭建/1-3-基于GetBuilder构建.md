# 1.3 基于 GetBuilder 构建

## Getx Full 存在问题

- 虽然规范，但文件过多
- obs Obx 性能不好

## GetBuilder 的模块开发步骤

---

### 第 1 步: 创建 Splash 模块

右键目录 pages/system 

菜单 “Getx: GetBuilder Page” 创建模块 “splash”

![Splash 模块](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/11/cab2fc6775a63affe21b5e6b7d4e8aea.png)

文件清单

```dart
└── splash
    ├── controller.dart
    ├── index.dart
    ├── view.dart
    └── widgets
```

| 名称            | 说明                 |
| --------------- | -------------------- |
| controller.dart | 控制器               |
| view.dart       | 页面                 |
| widgets         | 子组件（本模块私有） |
| index.dart      | 导包                 |

### 第 2 步: 阅读理解代码

controller.dart

```dart
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  _initData() {
    update(["splash"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
```

view.dart

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("SplashPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      id: "splash",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("splash")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}

```

> 就这两个文件，这次干净了

### 第 3 步: 尝试手动触发更新

- 加入点击更新 title 代码

lib/pages/system/splash/controller.dart

```dart
String title = "";
```

```dart
  void onTap(int ticket) {
    title = "GetBuilder -> 点击了第 $ticket 个按钮";
    update(['splash_title']);
  }
```

lib/pages/system/splash/view.dart

```dart
  // 主视图
  Widget _buildView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 文字标题
        GetBuilder<SplashController>(
          id: "splash_title",
          builder: (_) {
            return Center(
              child: Text(controller.title),
            );
          },
        ),

        // 按钮
        ElevatedButton(
          onPressed: () {
            controller.onTap(DateTime.now().microsecondsSinceEpoch);
          },
          child: const Text("立刻点击"),
        ),
      ],
    );
  }
```

- 路由注册

右键 lib 目录生成路由可选

![生成路由](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/11/c69168c42f6344bd44f3b11044838fa9.png)

lib/pages/index.dart

```dart
library pages;

...
  
export 'system/splash/index.dart';
```

lib/common/routers/names.dart

```dart
class RouteNames {
	...
  
  static const systemSplash = '/system_splash';
}

```

lib/common/routers/pages.dart

```dart
class RoutePages {
  // 列表
  static List<GetPage> list = [
    ...
    
    // splash 页面
    GetPage(
      name: RouteNames.systemSplash,
      page: () => const SplashPage(),
    ),
  ];
}

```

- 点击跳转 `splash`

lib/pages/system/login/view.dart1

```dart
  // 跳转
  ElevatedButton(
    onPressed: () {
      Get.toNamed(RouteNames.systemSplash);
    },
    child: const Text("跳转 splash"),
  ),
```

- 运行

![GetBuilder触发更新](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/11/2321258b6a21852a36e6db140d8a5332.png)

### 最后: 查看依赖 管理日志

我们进入模块后再退出，看下日志

```dart
[GETX] "SplashController" onDelete() called
[GETX] "SplashController" deleted from memory
[GETX] Instance "SplashController" already removed.
```

> 可以发现自动管理了内存加载释放，代码又进一步简洁了

> 提交代码到 git

```bash
git add .
git commit -m "1.3 基于 GetBuilder 构建"
```
