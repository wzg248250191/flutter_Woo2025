# 9.1 商品首页布局 sliver 编写

## 目标

采用 _build 编码模式整理界面布局。

> 为了保证整体滚动的一致性，我们用 `sliver` 家族来布局
> 如果没有这个需求用，用 `CustomScrollView` 就行了

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220720140701456.png" />

## 实现步骤：

---

### 第 1 步：i18n

lib/common/i18n/locale_keys.dart

```dart
  // 商品 - 首页
  static const gHomeSearch = 'goods_home_search';
  static const gHomeFlashSell = 'goods_home_flash_shell';
  static const gHomeNewProduct = 'goods_home_new_product';
  static const gHomeMore = 'goods_home_more';
```

lib/common/i18n/locales/locale_en.dart

```dart
  // 商品 - 首页
  LocaleKeys.gHomeSearch: 'Search Product',
  LocaleKeys.gHomeFlashSell: 'Flash Sell',
  LocaleKeys.gHomeNewProduct: 'New Product',
  LocaleKeys.gHomeMore: 'ALL',
```

lib/common/i18n/locales/locale_zh.dart

```dart
  // 商品 - 首页
  LocaleKeys.gHomeSearch: '搜索商品',
  LocaleKeys.gHomeFlashSell: '热卖商品',
  LocaleKeys.gHomeNewProduct: '新上商品',
  LocaleKeys.gHomeMore: '所有',
```

### 第 2 步：视图

lib/pages/goods/home/view.dart

各部分都需要用 `sliverToBoxAdapter` 包装

padding 需要用 `sliverPaddingHorizontal`

都是 `sliver` 家族

```dart
  // 导航栏
  AppBar _buildAppBar() {
    return AppBar();
  }

  // 轮播广告
  Widget _buildBanner() {
    return Container()
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  // 分类导航
  Widget _buildCategories() {
    return Container()
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  // Flash Sell
  Widget _buildFlashSell() {
    return Container()
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  // New Sell
  Widget _buildNewSell() {
    return Container()
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }
```

`_buildView` 主视图 进行组装

```dart
  // 主视图
  Widget _buildView() {
    return CustomScrollView(
      slivers: [
        // 轮播广告
        _buildBanner(),

        // 分类导航
        _buildCategories(),

        // Flash Sell
        // title
        Text(LocaleKeys.gHomeFlashSell.tr)
            .sliverToBoxAdapter()
            .sliverPaddingHorizontal(AppSpace.page),

        // list
        _buildFlashSell(),

        // new product
        // title
        Text(LocaleKeys.gHomeNewProduct.tr)
            .sliverToBoxAdapter()
            .sliverPaddingHorizontal(AppSpace.page),

        // list
        _buildNewSell(),
      ],
    );
  }
```

`build` 函数

```dart
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      id: "home",
      builder: (_) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildView(),
        );
      },
    );
  }
```

> 提交代码到 git

```sh
git add .
git commit -m "9.1 商品首页布局 sliver 编写"
```

