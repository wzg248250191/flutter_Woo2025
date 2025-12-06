import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/index.dart';

class Global {
  static Future<void> init() async {
    // 插件初始化
    WidgetsFlutterBinding.ensureInitialized();

    // 本地存储
    await Storage().init();

    // 初始化服务
    Get.put<ConfigService>(ConfigService());
    Get.put<WPHttpService>(WPHttpService());
    Get.put<UserService>(UserService()); // 用户服务

    // 初始化配置
    await ConfigService.to.init();
    Loading();
  }
}
