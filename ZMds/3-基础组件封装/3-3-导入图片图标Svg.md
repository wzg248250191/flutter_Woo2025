# 3.3 导入图片、图标 Svg

## 导入图片 png 图标 svg，实现步骤：

---

### 第 1 步：转换 3.0x 图片到 2.0x 1.0x

复制 png 到 `assets/images/3.0x` 目录

`assets`目录点击右键 "Assets: Images x1 x2 Generate"

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_SjgFfemaIW.png" alt="img" style="zoom: 50%;" />

> 支持的图片格式 jpeg jpg png

成功后会多出 `files.txt` `2.0x` `1.0x` 的文件

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_oGZpOVTZoC.png" alt="img" style="zoom:50%;" />

### 第 2 步：保存图片索引

打开 `files.txt`

```dart
static const defaultPng = 'assets/images/default.png';
static const orderConfirmedPng = 'assets/images/order-confirmed.png';
static const pMastercardPng = 'assets/images/p-mastercard.png';
static const pCashPng = 'assets/images/p-cash.png';
static const pPaypalPng = 'assets/images/p-paypal.png';
static const pVisaPng = 'assets/images/p-visa.png';
static const profileBackgroundPng = 'assets/images/profile-background.png';
static const welcomePng = 'assets/images/welcome.png';
static const welcome_2Png = 'assets/images/welcome_2.png';
static const welcome_1Png = 'assets/images/welcome_1.png';
static const welcome_3Png = 'assets/images/welcome_3.png';
```

> 可以发现按文件名规则自动生成了定义

创建 images 定义

lib/common/values/images.dart

```dart
class AssetsImages {
  static const defaultPng = 'assets/images/default.png';
  static const orderConfirmedPng = 'assets/images/order-confirmed.png';
  static const pCashPng = 'assets/images/p-cash.png';
  static const pMastercardPng = 'assets/images/p-mastercard.png';
  static const pPaypalPng = 'assets/images/p-paypal.png';
  static const pVisaPng = 'assets/images/p-visa.png';
  static const profileBackgroundPng = 'assets/images/profile-background.png';
  static const welcomePng = 'assets/images/welcome.png';
  static const welcome_1Png = 'assets/images/welcome_1.png';
  static const welcome_2Png = 'assets/images/welcome_2.png';
  static const welcome_3Png = 'assets/images/welcome_3.png';
}
```

> 复制过来就好了，手写还是比较麻烦，还容易写错

### 第 3 步：生成 svg 索引

复制 svg 到 `assets/svgs` 目录

`svgs`目录点击右键 "Assets: Images x1 x2 Generate"

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image__taYsEOVuK.png" alt="img" style="zoom:50%;" />

打开 `files.txt`

```dart
static const cBagSvg = 'assets/svgs/c-bag.svg';
static const cBikeSvg = 'assets/svgs/c-bike.svg';
static const cElectricSvg = 'assets/svgs/c-electric.svg';
static const cHomeSvg = 'assets/svgs/c-home.svg';
static const cKidsSvg = 'assets/svgs/c-kids.svg';
static const cManSvg = 'assets/svgs/c-man.svg';
static const cMoreSvg = 'assets/svgs/c-more.svg';
static const cWomanSvg = 'assets/svgs/c-woman.svg';
...
```

创建 svgs 定义

lib/common/values/svgs.dart

```dart
class AssetsSvgs {
  static const cBagSvg = 'assets/svgs/c-bag.svg';
  static const cBikeSvg = 'assets/svgs/c-bike.svg';
  static const cElectricSvg = 'assets/svgs/c-electric.svg';
  static const cHomeSvg = 'assets/svgs/c-home.svg';
  static const cKidsSvg = 'assets/svgs/c-kids.svg';
  static const cManSvg = 'assets/svgs/c-man.svg';
  static const cMoreSvg = 'assets/svgs/c-more.svg';
  static const cWomanSvg = 'assets/svgs/c-woman.svg';
  static const facebookSvg = 'assets/svgs/facebook.svg';
  static const googleSvg = 'assets/svgs/google.svg';
  static const iAddFriendSvg = 'assets/svgs/i-add-friend.svg';
  static const iAddSvg = 'assets/svgs/i-add.svg';
  static const iArrowBackSvg = 'assets/svgs/i-arrow-back.svg';
  static const iArrowBottomSvg = 'assets/svgs/i-arrow-bottom.svg';
  static const iArrowDownSvg = 'assets/svgs/i-arrow-down.svg';
  static const iArrowLeftUpSvg = 'assets/svgs/i-arrow-left-up.svg';
  static const iArrowRightSvg = 'assets/svgs/i-arrow-right.svg';
  static const iCameraSvg = 'assets/svgs/i-camera.svg';
  static const iCloseSvg = 'assets/svgs/i-close.svg';
  static const iCouponSvg = 'assets/svgs/i-coupon.svg';
  static const iIndicatorsSvg = 'assets/svgs/i-indicators.svg';
  static const iLikeSvg = 'assets/svgs/i-like.svg';
  static const iNotificationsSvg = 'assets/svgs/i-notifications.svg';
  static const iSearchSvg = 'assets/svgs/i-search.svg';
  static const iStarSvg = 'assets/svgs/i-star.svg';
  static const iSubtractSvg = 'assets/svgs/i-subtract.svg';
  static const iTrashSvg = 'assets/svgs/i-trash.svg';
  static const navCartSvg = 'assets/svgs/nav-cart.svg';
  static const navHomeSvg = 'assets/svgs/nav-home.svg';
  static const navMessageSvg = 'assets/svgs/nav-message.svg';
  static const navProfileSvg = 'assets/svgs/nav-profile.svg';
  static const pCurrencySvg = 'assets/svgs/p-currency.svg';
  static const pDeliverySvg = 'assets/svgs/p-delivery.svg';
  static const pGiftSvg = 'assets/svgs/p-gift.svg';
  static const pHomeSvg = 'assets/svgs/p-home.svg';
  static const pNotificationsSvg = 'assets/svgs/p-notifications.svg';
  static const pTranslateSvg = 'assets/svgs/p-translate.svg';
}
```

### 最后：yaml 配置

pubspec.yaml

```yaml
flutter:
  assets:
    - assets/images/
    - assets/svgs/
```

> 提交代码到 git

```sh
git add .
git commit -m "3.3 导入图片、图标 Svg"
```

