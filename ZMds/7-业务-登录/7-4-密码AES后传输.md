# 7.4 密码AES加密后传输

## 目标

了解密码加密与服务端交互过程。

![img](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_GMbzVMCLe9.png)

## AES 介绍

> 密码需要在传输中加密，防止被网关抓包，平时你们用的 wifi 都是可以被抓包的

https://zh.wikipedia.org/wiki/高级加密标准

**高级加密标准**（英语：**A**dvanced **E**ncryption **S**tandard，[缩写](https://zh.wikipedia.org/wiki/缩写)：AES），又称**Rijndael 加密法**（荷兰语发音：[ˈrɛindaːlˈ*r*ɛ*in**d**a*ː*l*](https://zh.wikipedia.org/wiki/Help:荷蘭語國際音標)，音似英文的“Rhine doll”），是[美国联邦政府](https://zh.wikipedia.org/wiki/美国联邦政府)采用的一种[区块加密](https://zh.wikipedia.org/wiki/區塊加密)标准。这个标准用来替代原先的[DES](https://zh.wikipedia.org/wiki/DES)，已经被多方分析且广为全世界所使用。经过五年的甄选流程，高级加密标准由[美国国家标准与技术研究院](https://zh.wikipedia.org/wiki/美国国家标准与技术研究院)（NIST）于 2001 年 11 月 26 日发布于 FIPS PUB 197，并在 2002 年 5 月 26 日成为有效的标准。现在，高级加密标准已然成为[对称密钥加密](https://zh.wikipedia.org/wiki/对称密钥加密)中最流行的[算法](https://zh.wikipedia.org/wiki/演算法)之一。

> 之所以选这个加密法，是因为 wordpress rest api 中的接口，输入的 password 是一个明文，其实输入 md5 签名更好。

![img](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_hJYKZaQfaY.png)

## 实现步骤：

---

### 第 1 步：安装插件 encrypt

```bash
flutter pub add encrypt
```

### 第 2 步：定义常量

lib/common/values/constants.dart

```dart
  // AES
  static const aesKey = 'aH5aH5bG0dC6aA3oN0cK4aU5jU6aK2lN';
  static const aesIV = 'hK6eB4aE1aF3gH5q';
```

> `aesKey` 加密 key 32 位
> `aesIV` 加密向量 16 位
> 具体的请联系后端工程师，保持一致可调通

### 第 3 步：创建加密类 encrypt

lib/common/utils/encrypt.dart

```dart
import 'package:encrypt/encrypt.dart';

import '../index.dart';

/// 加密类
class EncryptUtil {
  static final EncryptUtil _instance = EncryptUtil._internal();
  factory EncryptUtil() => _instance;
  EncryptUtil._internal() {
    // 加密器
    encrypter = Encrypter(AES(
      key, // 密钥
      mode: AESMode.cbc, // 模式
      padding: 'PKCS7', // 填充模式
    ));
  }

  /// 密钥
  final key = Key.fromUtf8(Constants.aesKey);

  /// 偏移量
  final iv = IV.fromUtf8(Constants.aesIV);

  late Encrypter encrypter;

  /// aes加密
  String aesEncode(String content) {
    // 加密
    final encrypted = encrypter.encrypt(content, iv: iv);
    // 返回 base64 编码
    return encrypted.base64;
  }
}
```

### 第 4 步：登录加密

lib/pages/system/login/controller.dart

```dart
  /// Sign In
  Future<void> onSignIn() async {
    if ((formKey.currentState as FormState).validate()) {
      try {
        Loading.show();

        // aes 加密密码
        var password = EncryptUtil().aesEncode(passwordController.text);

        UserToken res = await UserApi.login(UserLoginReq(
          ...
          password: password,
        ));
```

### 第 5 步：注册加密

lib/pages/system/register/controller.dart

```dart
  // 注册
  void onSignUp() {
    if ((formKey.currentState as FormState).validate()) {
      // aes 加密密码
      var password = EncryptUtil().aesEncode(passwordController.text);

      //验证通过
      Get.offNamed(
        RouteNames.systemRegisterPin,
        arguments: UserRegisterReq(
          ...
          password: password,
        ),
      );
    }
  }
```

> 提交代码到 git

```sh
git add .
git commit -m "7.4 密码AES加密后传输"
```

