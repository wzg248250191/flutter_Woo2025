# 8.2 图标组件加 Badge 提示

## 目标

给底部栏图标按钮加上 badge 。

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_nikgGgp34r.png"  />

## 实现步骤：

---

### 第 1 步：图标组件

lib/common/widgets/icon.dart

```dart
/// 图标组件
class IconWidget extends StatelessWidget {
  
  ...
  
  /// Badge 文字
  final String? badgeString;
```

```dart
  // 图标
  Widget _buildIcon(BuildContext context) {
    
    ...
    
		// badge
    if (isDot == true) {
      icon = Badge(
        backgroundColor: context.colors.scheme.primary,
        // smallSize: 10,
        alignment: Alignment.bottomRight,
        child: icon,
      );
    } else if (badgeString != null) {
      icon = Badge(
        backgroundColor: context.colors.scheme.primary,
        label: Text(badgeString!),
        alignment: Alignment.topRight,
        child: icon,
      );
    }
```

> Badge 组件采用 material 官方组件

### 第 2 步：导航组件

```dart
  @override
  Widget build(BuildContext context) {
    ...

          // 图标
          IconWidget.svg(
            item.icon,
            size: 24,
            color: color,
            badgeString: item.count > 0 ? item.count.toString() : null,
          ).paddingBottom(2),
```

> badgeString 提示文字

### 第 3 步：main 视图中加入

lib/pages/system/main/view.dart

```dart
  // 主视图
  Widget _buildView() {
    ...
            return BuildNavigation(
              currentIndex: controller.currentIndex,
              items: [
                NavigationItemModel(
                  label: LocaleKeys.tabBarHome.tr,
                  icon: AssetsSvgs.navHomeSvg,
                ),
                NavigationItemModel(
                  label: LocaleKeys.tabBarCart.tr,
                  icon: AssetsSvgs.navCartSvg,
                  count: 3,
                ),
                NavigationItemModel(
                  label: LocaleKeys.tabBarMessage.tr,
                  icon: AssetsSvgs.navMessageSvg,
                  count: 9,
                ),
                NavigationItemModel(
                  label: LocaleKeys.tabBarProfile.tr,
                  icon: AssetsSvgs.navProfileSvg,
                ),
              ],
              onTap: controller.onJumpToPage, // 切换tab事件
            );
```

> 后期可以用 obs 响应变量更新

> 提交代码到 git

```sh
git add .
git commit -m "8.2 图标组件加 Badge 提示"
```

