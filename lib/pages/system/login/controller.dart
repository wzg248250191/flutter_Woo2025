import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class LoginController extends GetxController {
  LoginController();

  final state = LoginState();

  /// 用户名
  TextEditingController userNameController = TextEditingController(
    text: "ducafecat5",
  );

  /// 密码
  TextEditingController passwordController = TextEditingController(
    text: "123456",
  );

  /// 表单 key
  GlobalKey formKey = GlobalKey<FormState>();

  /// Sign In
  Future<void> onSignIn() async {
    if ((formKey.currentState as FormState).validate()) {
      try {
        Loading.show();

        // aes 加密密码
        var password = EncryptUtil().aesEncode(passwordController.text);

        // api 请求
        UserTokenModel res = await UserApi.login(
          UserLoginReq(username: userNameController.text, password: password),
        );

        // 本地保存 token
        await UserService.to.setToken(res.token!);
        // 获取用户资料
        await UserService.to.getProfile();

        Loading.success();
        Get.back(result: true);
      } finally {
        Loading.dismiss();
      }
    }
  }

  // tap
  void handleTap(int index) {
    Get.snackbar("标题", "消息");
  }

  // tap
  void onTap(int index) {
    state.title = '点击了第$index个按钮';
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  /// 释放
  @override
  void onClose() {
    super.onClose();
    userNameController.dispose();
    passwordController.dispose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}
