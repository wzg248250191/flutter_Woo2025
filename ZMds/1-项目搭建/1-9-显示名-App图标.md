# 1.9 显示名、App 图标

## 一、改程序名、包名

---

### rename 工具

https://pub.dev/packages/rename

```sh
flutter pub global activate rename
```

### 改包名

```sh
flutter pub global run rename setBundleId --value com.ducafecat.woo2025
```

### 改程序名

```sh
flutter pub global run rename setAppName --value woo2025
```

## 二、App 图标修改：

---

### 图标设计

https://www.canva.com/logos/templates/

![canva.com](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/12/3fb35c2b4ffa5c9a1f436f4115dd13f0.png)

### 图标工具

https://icon.kitchen/

![icon.kitchen](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/12/961c3f7774dc7be5a2c664f53b86f72e.png)

### 第 1 步：安装插件 icons_launcher

https://pub.dev/packages/icons_launcher

```bash
flutter pub add icons_launcher -d
```

### 第 2 步：pubspec.yaml 配置

复制图片到 

assets/icons/ic_logo.png

assets/icons/ic_background.png

assets/icons/ic_foreground.png

![图标](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/11/c7960f21ddb79b24ae219a52d4a48a49.png)

pubspec.yaml

```yaml
# app 图标
icons_launcher:
  image_path: "assets/icons/ic_logo.png"
  platforms:
    android:
      enable: true
      notification_image: "assets/icons/ic_foreground.png"
      # adaptive_background_color: '#ffffff'
      adaptive_background_image: "assets/icons/ic_background.png"
      adaptive_foreground_image: "assets/icons/ic_foreground.png"
    ios:
      enable: true
```

> `android` `ios` true 覆盖资源文件
> `image_path` 图标图片 png
> `adaptive_background_image` 图标背景图
> `adaptive_foreground_image` 图标前景图

### 第 3 步：执行命令

在项目更目录执行

```bash
flutter pub get
dart run icons_launcher:create
```

android

![android icon](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/11/43b86e2ecdcf8aac88b4c7ebdc3d923f.png)

ios

![ios icon](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2024/11/133174a952e905faa1715a3586041088.png)

> 提交代码到 git

```bash
git add .
git commit -m "1.9 显示名、App 图标"
```
