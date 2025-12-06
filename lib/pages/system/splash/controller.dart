// ignore_for_file: unused_element

import 'package:get/get.dart';

import '../../../common/index.dart';

class SplashController extends GetxController {
  SplashController();
  String title = "";

  void onTap(int ticket) {
    title = "GetBuilder -> 点击了第 $ticket 个按钮";
    update(['splash_title']);
  }

  _initData() {
    update(["splash"]);
  }

  /// 跳转页面
  _jumpToPage() {
    // 延迟1秒
    Future.delayed(const Duration(seconds: 1)).then((_) {
      // 是否已打开
      if (ConfigService.to.isAlreadyOpen) {
        // 跳转首页
        Get.offAllNamed(RouteNames.systemMain);
      } else {
        // 跳转欢迎页
        Get.offAllNamed(RouteNames.systemWelcome);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();

    // 设置系统样式
    AppTheme.setSystemStyle();
  }

  @override
  void onReady() {
    super.onReady();
    _jumpToPage(); // 跳转界面
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
