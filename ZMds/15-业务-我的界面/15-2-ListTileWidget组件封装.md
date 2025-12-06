# 15.2 ListTileWidget 组件封装

## 目标

编写一个类似 `ListTileWidget` 的组件，但是自由度更大。

![ListTileWidget列表项组件](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/12/81de8d416c8ee0c1041ed590b7ead3f5.png)

## 实现步骤：

---

> 官方的 `ListTile` 虽然很方便，但是有两个主要问题
>
> 1. 不能改高度
> 2. 自定义能力还有点不足
>
> 所以我们项目中需要自己去实现一个 `ListTileWidget`

### 第 1 步：功能分析

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_dkCB_TsuKX.png"  />

功能：

1. 左右图标
2. 标题、子标题、描述
3. 尺寸、间距、边距
4. 事件、点击、长按

### 第 2 步：组件代码

lib/common/widgets/list_tile.dart

```dart
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import '../index.dart';

/// 列表项
class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.leadingSpace,
    this.trailing,
    this.trailingSpace,
    this.padding,
    this.crossAxisAlignment,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.borderWidth,
    this.elevation,
    this.backgroundColor,
  });

  /// 标题
  final Widget? title;

  /// 子标题
  final Widget? subtitle;

  /// 左侧图标
  final Widget? leading;

  /// 左侧图标间距
  final double? leadingSpace;

  /// 右侧图标
  final List<Widget>? trailing;

  /// 右侧图标间距
  final double? trailingSpace;

  /// padding 边框间距
  final EdgeInsetsGeometry? padding;

  /// cross 对齐方式
  final CrossAxisAlignment? crossAxisAlignment;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 长按事件
  final GestureLongPressCallback? onLongPress;

  /// 圆角
  final double? borderRadius;

  /// 边框
  final double? borderWidth;

  /// 阴影
  final double? elevation;

  /// 背景色
  final Color? backgroundColor;

  // 主视图
  Widget _buildView(BuildContext context) {
    List<Widget> ws = [];

    // 左侧图标
    if (leading != null) {
      ws.add(leading!);
      // 左侧间距
      ws.add(SizedBox(width: leadingSpace ?? AppSpace.column));
    }

    // 标题，子标题
    if (title != null || subtitle != null) {
      var titleList = [
        if (title != null) title!,
        if (subtitle != null) subtitle!,
      ];
      ws.add(
        titleList.length == 1
            ? titleList.first.expanded()
            : titleList
                .toColumn(
                  crossAxisAlignment:
                      crossAxisAlignment ?? CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                )
                .expanded(),
      );
    }

    // 左侧图标
    if (trailing != null) {
      // 右侧间距
      if (trailingSpace != null) {
        ws.add(SizedBox(width: trailingSpace));
      }

      // 右侧图标
      ws.add(
        trailing!.length == 1
            ? trailing!.first
            : trailing!.toRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              ),
      );
    }

    // 背景、圆角、边框
    Widget child = ws.toRow().padding(
          horizontal: padding?.horizontal ?? AppPadding.listTile.horizontal,
          vertical: padding?.vertical ?? AppPadding.listTile.vertical,
        );

    // 涟漪, 点击事件
    if (onTap != null) {
      child = child.ripple();
    }

    // 背景、圆角、边框
    if (borderWidth != null && borderWidth! > 0) {
      child = child.decorated(
        color: backgroundColor ?? context.colors.scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppRadius.listTile,
        ),
        border: Border.all(
          color: context.colors.primary,
          width: borderWidth ?? AppBorder.listTile,
        ),
      );
    } else {
      child = child.decorated(
        color: backgroundColor ?? context.colors.scheme.surface,
      );
    }

    // 裁切圆形, 点击事件，把涟漪一起切成圆形
    if (onTap != null) {
      child = child.clipRRect(
        all: borderRadius ?? AppRadius.listTile,
      );
    }

    // 阴影
    if (elevation != null && elevation! > 0) {
      child = child.elevation(
        elevation ?? AppElevation.listTile,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppRadius.listTile,
        ),
        shadowColor: context.colors.shadow,
      );
    }

    // 点击事件
    if (onTap != null || onLongPress != null) {
      child = child.gestures(
        onTap: onTap,
        onLongPress: onLongPress,
      );
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}
```

## 第 3 步：调试页面

lib/pages/styles/list_tile/view.dart

```dart
  // 头像
  Widget _buildAvatar(String svgPath) {
    return IconWidget.svg(
      svgPath,
      size: 28,
    );
  }
```

```dart
  // 按钮
  Widget _buildAiButton(BuildContext context, IconData iconData) {
    return ButtonWidget.icon(
      IconWidget.icon(
        iconData,
        color: context.colors.primary,
      ).backgroundColor(context.colors.scheme.surfaceContainer).tightSize(28),
      onTap: () {},
    );
  }
```

```dart
  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      // 主标题、副标题、左侧图标、右侧图标
      const TextWidget.label('主标题、副标题、左侧图标、右侧图标'),
      const ListTileWidget(
        title: TextWidget.label("title"),
        subtitle: TextWidget.muted("subtitle"),
        leading: IconWidget.icon(Icons.login),
        trailing: <Widget>[
          IconWidget.icon(Icons.arrow_forward_ios),
        ],
      ),

      // 主标题、左侧图标、右侧图标
      const TextWidget.label('主标题、左侧图标、右侧图标'),
      const ListTileWidget(
        title: TextWidget.label("title"),
        leading: IconWidget.icon(Icons.login),
        trailing: <Widget>[
          IconWidget.icon(Icons.arrow_forward_ios),
        ],
      ),

      // svg 图标、背景色
      const TextWidget.label('svg 图标、背景色'),
      ListTileWidget(
        title: const TextWidget.label("编程助手"),
        subtitle: const TextWidget.muted("输入你的编程语言和需求"),
        leading: _buildAvatar(AssetsSvgs.cBagSvg),
        trailing: <Widget>[
          _buildAiButton(context, Icons.play_arrow),
        ],
        backgroundColor: context.colors.scheme.surfaceContainer,
      ),

      // svg 图标、背景色
      const TextWidget.label('svg 图标、背景色'),
      ListTileWidget(
        title: const TextWidget.label("写作助手"),
        subtitle: const TextWidget.muted("输入你的文章标题和内容范围"),
        leading: _buildAvatar(AssetsSvgs.cBikeSvg),
        trailing: <Widget>[
          _buildAiButton(context, Icons.stop),
        ],
        backgroundColor: context.colors.scheme.tertiaryContainer,
      ),

      // end
    ].toColumnSpace().paddingAll(AppSpace.page).scrollable();
  }
```

```dart
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListTileController>(
      init: ListTileController(),
      id: "list_tile",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("list_tile 列表项")),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
```

lib/pages/styles/styles_index/view.dart

```dart
      // ListTile 列表项
      ListTile(
        onTap: () => Get.toNamed(RouteNames.stylesListTile),
        title: const Text("ListTile 列表项"),
      ),
```

用户首页加入样式页入口

lib/pages/my/my_index/view.dart

```dart
  // 按钮列表
  Widget _buildButtonsList(BuildContext context) {
    return <Widget>[
      // 样式页
      ListTileWidget(
        title: const Text("样式页"),
        leading: const IconWidget.svg(
          AssetsSvgs.cBagSvg,
          size: 28,
        ),
        trailing: const <Widget>[
          IconWidget.icon(Icons.arrow_forward_ios),
        ],
        onTap: () => Get.toNamed(RouteNames.stylesStylesIndex),
      ),
    ].toColumn().card();
  }
```

![我的界面样式入口](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/12/5363039972714332e818639475ef7348.png)

> 提交代码到 git

```sh
git add .
git commit -m "15.2 ListTileWidget 组件封装"
```
