# 5.2 SliderIndicatorWidget 封装

## 目标

编写 slider indicator 指示标组件。

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220713134021845.png" alt="slider indicator " />

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220713134104294.png" alt="slider indicator "  />

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220713134137620.png" alt="slider indicator " />

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_chYe83b7jS.png" alt="slider indicator " />

## 实现步骤：

---

### 第 1 步：SliderIndicatorWidget 类

lib/common/components/slider_indicator.dart

```dart
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';

/// slider indicator 指示器
class SliderIndicatorWidget extends StatelessWidget {
  /// 个数
  final int length;

  /// 当前位置
  final int currentIndex;

  /// 颜色
  final Color? color;

  /// 是否原型
  final bool isCircle;

  /// 对齐方式
  final MainAxisAlignment alignment;

  const SliderIndicatorWidget({
    super.key,
    required this.length,
    required this.currentIndex,
    this.color,
    this.isCircle = false,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    Color boxColor = color ?? context.colors.scheme.primary;

    return Row(
      mainAxisAlignment: alignment,

      // 采用 list.generate 方式生成 item 项
      children: List.generate(length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          // 圆型宽度 6 , 否则当前位置 15 , 其他位置 8
          width: !isCircle
              ? currentIndex == index
                  ? 15.0
                  : 8
              : 6,
          // 圆型高度 6 , 否则 4
          height: !isCircle ? 4 : 6,
          decoration: BoxDecoration(
            // 圆角 4
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            // 非当前位置透明度 0.3
            color: currentIndex == index ? boxColor : boxColor.withOpacity(0.3),
          ),
        );
      }),
    );
  }
}
```

### 第 2 步：控制器

lib/pages/system/welcome/controller.dart

```dart
  /// 当前位置
	int currentIndex = 0;
```

```dart
	/// 当前位置发生改变
  void onPageChanged(int index) {
    currentIndex = index;
    update(['slider', 'bar']);
  }
```

```dart
  /// 初始化数据
  _initData() {
    ...

    update(["slider", 'bar']);
  }
```

>  'bar' 不要漏了。

### 第 3 步：视图

lib/pages/system/welcome/view.dart

```dart
  /// 控制栏
  Widget _buildBar() {
    return GetBuilder<WelcomeController>(
      id: "bar",
      init: controller,
      builder: (controller) {
        return <Widget>[
          // 指示标
          SliderIndicatorWidget(
            length: 3,
            currentIndex: controller.currentIndex,
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
            ),
    );
  }
```

> 实现 onPageChanged 事件

```dart
  /// 主视图
  Widget _buildView() {
    return <Widget>[
      // slider切换
      _buildSlider(),

      // 控制栏
      _buildBar(),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
        .paddingAll(AppSpace.page);
  }
```

> 提交代码到 git

```sh
git add .
git commit -m "5.2 SliderIndicatorWidget 封装"
```

