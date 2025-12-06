# 4.2 splash 启动界面

## Splash 作用

- 让 flutter 视图引擎有个缓存热身时间
- 在 splash 决定去哪个界面

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220712145325923.png" alt="image-20220712145325923" style="zoom:50%;" />

## 实现步骤：

---

### 第 1 步：加入图片到 assets

将图片放入 assets/images/3.0x

然后执行 `Assets: Images x1 x2 Generate` 生成需要的 x1 x2 图片

![img](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_7_-oDpvt7w.png)

复制 `files.txt` 配置到 `lib/common/values/images.dart`

```dart
class AssetsImages {
  ...
  static const splashJpg = 'assets/images/splash.jpg';
}
```

### 第 2 步：修改 splash

lib/pages/system/splash/view.dart

```dart
  // 主视图
  Widget _buildView() {
    return const ImageWidget.img(
      AssetsImages.splashJpg,
      fit: BoxFit.fill, // 填充整个界面
    );
  }
```

```dart
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      id: "splash",
      builder: (_) {
        return _buildView();
      },
    );
  }
```

### 第 3 步：修改 main 路由

lib/main.dart

```dart
// 路由
initialRoute: RouteNames.systemSplash,
```

### 最后：运行

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_WCL6mAWWu_.png" alt="image_WCL6mAWWu_" style="zoom:25%;" />

> 提交代码到 git

```sh
git add .
git commit -m "4.2 splash 启动界面"
```

