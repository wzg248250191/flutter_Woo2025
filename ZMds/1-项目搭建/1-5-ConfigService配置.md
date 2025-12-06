# 1.5 config service 配置

## 目标

实现全局配置类 ConfigService 。

## GetxService

GetxService 适合用于需要在应用中长期存在的服务，提供了更好的资源管理和生命周期控制。

GetxService 是一个抽象类，主要用于在 Flutter 应用中管理服务的生命周期。与 GetxController 不同，GetxService 不会自动被销毁，适合那些一旦启动后会一直驻留在内存中的服务，例如身份验证控制等。以下是 GetxService 的一些主要作用和使用场景：

- 持久性服务：适用于需要在整个应用生命周期内保持状态的服务，比如用户认证、配置管理等。

- 手动管理生命周期：由于 GetxService 不会自动被删除，开发者需要手动调用 Get.reset() 来移除它。这使得开发者可以更灵活地控制服务的生命周期。

- 资源管理：可以在 onClose 方法中释放资源，避免内存泄漏，例如关闭流或释放控制器。

- 初始化和准备：在 onInit 和 onReady 方法中可以进行初始化和准备工作，例如设置监听器或进行异步请求。

## 代码实现

---

### 第 1 步: 安装依赖包 package_info_plus

```dart
flutter pub add package_info_plus
```

### 第 2 步: 创建 ConfigService

lib/common/services/config.dart

```dart
/// 配置服务
class ConfigService extends GetxService {
  // 这是一个单例写法
  static ConfigService get to => Get.find();

  // 包信息
  PackageInfo? _platform;

  // 版本号
  String get version => _platform?.version ?? '-';

  // 初始化
  Future<ConfigService> init() async {
    await getPlatform();
    return this;
  }

  // 获取包信息
  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }
}
```

> static ConfigService get to => Get.find(); 这是一个单例写法

### 第 3 步: 创建 Global

lib/global.dart

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/index.dart';

class Global {
  static Future<void> init() async {
    // 插件初始化
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化队列
    await Future.wait([
      // 配置服务
      Get.putAsync<ConfigService>(() async => await ConfigService().init()),
    ]).whenComplete(() {});
  }
}

```

> `Get.put` 方式直接注入

`WidgetsFlutterBinding.ensureInitialized();` 这个表示先就行原生端（ios android）插件注册，然后再处理后续操作，这样能保证代码运行正确。

修改 `main.dart`

```dart
Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}
```

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 标题
      title: 'Flutter Demo',

      // 主题
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),

      // 路由
      initialRoute: RouteNames.systemSplash,
      getPages: RoutePages.list,
      navigatorObservers: [RoutePages.observer],
    );
  }
}
```

> 注意这里有个 `async` 同步的操作，保证 `Service` 正常初始化。

### 最后: 在 SplashPage 中调用

```dart
class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  Widget _buildView() {
    return Center(
      child: Text("SplashPage - ${ConfigService.to.version}"),
    );
  }
```

注意看这里的 `ConfigService.to.version` 这是单例的调用，使用很便利。

运行后显示当前版本号

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_JM4yLZLi25.png" alt="img" style="zoom:25%;" />

> 提交代码到 git

```bash
git add .
git commit -m "1.5 config service 配置"
```
