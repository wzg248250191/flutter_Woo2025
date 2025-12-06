# 5.1 WelcomeSlider 封装


## 目标

封装 slider 业务组件。

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220713132606210.png" alt="image-20220713132606210" />

## 实现步骤：

---

### 第 1 步：安装插件 carousel_slider

```bash
flutter pub add carousel_slider
```

### 第 2 步：i18n 配置

lib/common/i18n/locale_keys.dart

```dart
  // 欢迎页
  static const welcomeOneTitle = 'welcome_one_title';
  static const welcomeOneDesc = 'welcome_one_desc';
  static const welcomeTwoTitle = 'welcome_two_title';
  static const welcomeTwoDesc = 'welcome_two_desc';
  static const welcomeThreeTitle = 'welcome_three_title';
  static const welcomeThreeDesc = 'welcome_three_desc';
  static const welcomeSkip = 'welcome_skip';
  static const welcomeNext = 'welcome_next';
  static const welcomeStart = 'welcome_start';
```

lib/common/i18n/locales/locale_en.dart

```dart
  // welcome 欢迎
  LocaleKeys.welcomeOneTitle: 'Choose Your Desire Product',
  LocaleKeys.welcomeOneDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeTwoTitle: 'Complete your shopping',
  LocaleKeys.welcomeTwoDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeThreeTitle: 'Get product at your door',
  LocaleKeys.welcomeThreeDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeSkip: 'Skip',
  LocaleKeys.welcomeNext: 'Next',
  LocaleKeys.welcomeStart: 'Get Started',
```

lib/common/i18n/locales/locale_zh.dart

```dart
  // welcome 欢迎
  LocaleKeys.welcomeOneTitle: '选择您喜欢的产品',
  LocaleKeys.welcomeOneDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeTwoTitle: '完成您的购物',
  LocaleKeys.welcomeTwoDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeThreeTitle: '足不出户的购物体验',
  LocaleKeys.welcomeThreeDesc:
      'Contrary to popular belief, Lorem Ipsum is not simply random text',
  LocaleKeys.welcomeSkip: '跳过',
  LocaleKeys.welcomeNext: '下一页',
  LocaleKeys.welcomeStart: '立刻开始',
```

### 第 3 步：WelcomeModel 类

lib/common/models/welcome_model.dart

```dart
/// 欢迎数据 Model
class WelcomeModel {
  /// 图片url
  String? image;

  /// 标题
  String? title;

  /// 说明
  String? desc;

  WelcomeModel({this.image, this.title, this.desc});

  WelcomeModel.fromJson(dynamic json) {
    image = json["image"];
    title = json["title"];
    desc = json["desc"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = image;
    map["title"] = title;
    map["desc"] = desc;
    return map;
  }
}

```

### 第 4 步：WelcomeSlider 类

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220713132606210.png" alt="image-20220713132606210" style="zoom: 33%;" />

lib/common/components/welcome_slider.dart

```dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';

import '../index.dart';

/// 欢迎 slider
class WelcomeSliderWidget extends StatelessWidget {
  /// 项目
  final List<WelcomeModel> items;

  /// 页数发生变化
  final Function(int) onPageChanged;

  /// 控制器
  final CarouselSliderController? carouselController;

  const WelcomeSliderWidget(
    this.items, {
    super.key,
    required this.onPageChanged,
    this.carouselController,
  });

  Widget sliderItem(WelcomeModel item) {
    return Builder(
      builder: (BuildContext context) {
        return <Widget>[
          // 图
          if (item.image != null)
            ImageWidget.img(
              item.image!,
              fit: BoxFit.cover,
            ),

          // 标题
          if (item.title != null)
            TextWidget.h1(
              item.title ?? "",
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
            ),

          // 描述
          if (item.desc != null)
            TextWidget.label(
              item.desc ?? "",
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.center,
            )
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
            .width(MediaQuery.of(context).size.width);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        height: 500.w,
        viewportFraction: 1, // 充满
        enlargeCenterPage: false, // 动画 封面效果
        enableInfiniteScroll: false, // 无限循环
        autoPlay: false, // 自动播放
        onPageChanged: (index, reason) => onPageChanged(index),
      ),
      items: <Widget>[
        for (var item in items) sliderItem(item),
      ].toList(),
    );
  }
}
```

### 第 5 步：控制器

lib/pages/system/welcome/controller.dart

```dart
  /// 欢迎数据
  List<WelcomeModel>? items;
```

```dart
  /// 初始化数据
  _initData() {
    items = [
      WelcomeModel(
        image: AssetsImages.welcome_1Png,
        title: LocaleKeys.welcomeOneTitle.tr,
        desc: LocaleKeys.welcomeOneDesc.tr,
      ),
      WelcomeModel(
        image: AssetsImages.welcome_2Png,
        title: LocaleKeys.welcomeTwoTitle.tr,
        desc: LocaleKeys.welcomeTwoDesc.tr,
      ),
      WelcomeModel(
        image: AssetsImages.welcome_3Png,
        title: LocaleKeys.welcomeThreeTitle.tr,
        desc: LocaleKeys.welcomeThreeDesc.tr,
      ),
    ];

    update(["slider"]);
  }
```

```dart
  @override
  void onReady() {
    super.onReady();
    _initData();
  }
```

### 第 6 步：视图

lib/pages/system/welcome/view.dart

```dart
  /// 轮播图
  Widget _buildSlider() {
    return GetBuilder<WelcomeController>(
      id: "slider",
      init: controller,
      builder: (controller) => controller.items == null
          ? const SizedBox()
          : WelcomeSliderWidget(
              controller.items!,
              onPageChanged: (index) {},
            ),
    );
  }
```

```dart
  /// 主视图
  Widget _buildView() {
    return <Widget>[
      // slider切换
      _buildSlider(),
      // 控制栏
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
        .paddingAll(AppSpace.page);
  }
```

```dart
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      id: "welcome",
      builder: (_) {
        return Scaffold(
          // appBar: AppBar(title: const Text("welcome")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
```

### 第 7 步：splash 跳转到 welcome

lib/pages/system/splash/controller.dart

```dart
  _jumpToPage() {
    // 欢迎页
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(RouteNames.systemWelcome);
    });
  }
```

```dart
  @override
  void onReady() {
    super.onReady();
    // _initData(); // 初始数据
    _jumpToPage(); // 跳转界面
  }
```

### 最后：运行

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_OmXlYVEMJL.png" alt="img" style="zoom:25%;" />

> 提交代码到 git

```sh
git add .
git commit -m "5.1 WelcomeSlider 封装"
```

