# 14.9 拉取商品 sliver 滚动

## 目标

使用 `sliver` 实现上下拉数据列表。

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_rsNGQNdAEz.png" />

## 实现步骤：

---

### 第 1 步：商品 api

接口参数

![商品api](https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_rI51m1kQ6W.png)

### 第 2 步：控制器

lib/pages/search/search_filter/controller.dart

```dart
  // 商品 tagId , 获取路由传递参数
  int? tagId = Get.arguments["tagId"] ?? "";
  // 商品列表
  List<ProductModel> items = [];
```

```dart
  // 刷新控制器
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );
  // 页码
  int _page = 1;
  // 页尺寸
  final int _limit = 20;
  // 排序字段
  // date, id, include, title, slug, price, popularity and rating. Default is date.
  final String _orderBy = "id";
  // 排序方向
  // asc and desc. Default is desc.
  final String _order = "desc";
```

```dart
  // 拉取数据
  // isRefresh 是否是刷新
  Future<bool> _loadSearch(bool isRefresh) async {
    // 拉取数据
    var result = await ProductApi.products(ProductsReq(
      // 刷新, 重置页数1
      page: isRefresh ? 1 : _page,
      // 每页条数
      prePage: _limit,
      // slug
      tag: "$tagId",
      // 排序字段
      orderby: _orderBy,
      // 排序方向
      order: _order,
      // 价格范围
      minPrice: "${priceRange[0]}",
      maxPrice: "${priceRange[1]}",
    ));

    // 下拉刷新
    if (isRefresh) {
      _page = 1; // 重置页数1
      items.clear(); // 清空数据
    }

    // 有数据
    if (result.isNotEmpty) {
      _page++; // 页数+1
      items.addAll(result); // 添加数据
      // 调试列表
      items.addAll(result);
      items.addAll(result);
      items.addAll(result);
    }

    // 是否空
    return result.isEmpty;
  }
```

```dart
  // 上拉载入新商品
  void onLoading() async {
    if (items.isNotEmpty) {
      try {
        // 拉取数据是否为空
        var isEmpty = await _loadSearch(false);

        if (isEmpty) {
          // 设置无数据
          refreshController.loadNoData();
        } else {
          // 加载完成
          refreshController.loadComplete();
        }
      } catch (e) {
        // 加载失败
        refreshController.loadFailed();
      }
    } else {
      // 设置无数据
      refreshController.loadNoData();
    }
    update(["filter_products"]);
  }
```

```dart
  // 下拉刷新
  void onRefresh() async {
    try {
      await _loadSearch(true);
      // 刷新完成
      refreshController.refreshCompleted();
    } catch (error) {
      // 刷新失败
      refreshController.refreshFailed();
    }
    update(["filter_products"]);
  }
```

```dart
  // 筛选 应用
  void onFilterApplyTap() {
    refreshController.requestRefresh();
    Get.back();
  }
```

```dart
  @override
  void onClose() {
    super.onClose();
    // 刷新控制器释放
    refreshController.dispose();
  }
```

### 第 3 步：FilterView 视图

> 点击应用的时候，刷新数据

lib/pages/search/search_filter/widgets/filter_view.dart

```dart
  Widget _buildView() {
    return <Widget>[
      ...

      const Divider(),

      // 应用按钮
      ButtonWidget.primary(
        LocaleKeys.commonBottomApply.tr,
        onTap: controller.onFilterApplyTap,
      ).width(double.infinity),

      ...
```

### 第 4 步：视图

lib/pages/search/search_filter/view.dart

```dart
  // 数据列表
  Widget _buildListView(BuildContext context) {
    return GetBuilder<SearchFilterController>(
      id: "filter_products",
      builder: (_) {
        return controller.items.isEmpty
            ?
            // 占位图
            const PlaceholdWidget().sliverBox
            :
            // 数据列表
            SliverGrid.extent(
                maxCrossAxisExtent: 120,
                mainAxisSpacing: AppSpace.listRow, // 主轴间距
                crossAxisSpacing: AppSpace.listItem, // 交叉轴间距
                childAspectRatio: 0.7, // 宽高比
                children: controller.items.map((product) {
                  return ProductItemWidget(
                    product, // 商品
                    imgHeight: 117.w, // 图片高度
                  );
                }).toList(),
              );
      },
    );
  }
```

```dart
  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      // 筛选栏
      _buildFilterBar(context),

      // 数据列表
      SmartRefresher(
        controller: controller.refreshController, // 刷新控制器
        enablePullUp: true, // 启用上拉加载
        onRefresh: controller.onRefresh, // 下拉刷新回调
        onLoading: controller.onLoading, // 上拉加载回调
        footer: const SmartRefresherFooterWidget(), // 底部加载更多
        child: CustomScrollView(
          slivers: [
            _buildListView(context).sliverPaddingHorizontal(AppSpace.button),
          ],
        ),
      ).expanded(),
    ].toColumn();
  }
```

> 这里是课程设计需要，`SmartRefresher` 包裹 `sliver` 组件。

> `SmartRefresher` 包含 `GridList` 并嵌入`Column` 中进行上下拉操作，需要用到 `sliver` 来衔接。

> 提交代码到 git

```sh
git add .
git commit -m "14.9 拉取商品 sliver 滚动"
```

