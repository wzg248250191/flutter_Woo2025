# 5.3 Skip、Next、Start 按钮联动

## 目标

实现底部导航按钮栏位。

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220713135816995.png" alt="Skip、Next、Start 按钮联动" />

## 实现步骤：

---

### 第 1 步：控制器

lib/pages/system/welcome/controller.dart

```dart
  /// 是否显示 Start
  bool isShowStart = false;

  /// slider 控制器
  CarouselSliderController carouselController = CarouselSliderController();
```

```dart
  /// 当前位置发生改变
  void onPageChanged(int index) {
    currentIndex = index;
    isShowStart = currentIndex == 2;
    update(['slider', 'bar']);
  }
```

```dart
  /// 去首页
  void onToMain() {
    /// 跳转首页, 并关闭所有页面
    Get.offAllNamed(RouteNames.systemMain);
  }
```

```dart
  /// 下一个
  void onNext() {
    carouselController.nextPage();
  }
```

### 第 2 步：视图

lib/pages/system/welcome/view.dart

```dart
  /// 控制栏
  Widget _buildBar() {
    return GetBuilder<WelcomeController>(
      id: "bar",
      init: controller,
      builder: (controller) {
        return controller.isShowStart
            ?
            // 开始
            ButtonWidget.primary(
                LocaleKeys.welcomeStart.tr,
                onTap: controller.onToMain,
              ).tight(
                width: double.infinity,
              )
            : <Widget>[
                // 跳过
                ButtonWidget.ghost(
                  LocaleKeys.welcomeSkip.tr,
                  onTap: controller.onToMain,
                ),
                // 指示标
                SliderIndicatorWidget(
                  length: 3,
                  currentIndex: controller.currentIndex,
                ),
                // 下一页
                ButtonWidget.ghost(
                  LocaleKeys.welcomeNext.tr,
                  onTap: controller.onNext,
                ),
              ].toRow(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              );
      },
    );
  }
```

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
              onPageChanged: controller.onPageChanged,
              carouselController: controller.carouselController,
            ),
    );
  }
```

> 设置了 carouselController 对象

### 最后：运行

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_Tlsj0M0bPP.png" alt="img" style="zoom:25%;" />

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_rviIoeDXsT.png" alt="img" style="zoom:25%;" />

> 提交代码到 git

```sh
git add .
git commit -m "5.3 Skip、Next、Start 按钮联动"
```

