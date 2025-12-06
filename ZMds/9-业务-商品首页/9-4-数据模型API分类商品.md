# 9.4 数据模型、API（分类、商品）

## 目标

编写商品数据实例类。

## 实现步骤：

---

### 第 1 步：分类返回

数据结构

```json
[
  {
    "id": 34,
    "name": "Bag",
    "slug": "bag",
    "parent": 0,
    "description": "",
    "display": "default",
    "image": {
      "id": 63,
      "date_created": "2022-04-09T09:58:41",
      "date_created_gmt": "2022-04-09T01:58:41",
      "date_modified": "2022-04-09T09:58:41",
      "date_modified_gmt": "2022-04-09T01:58:41",
      "src": "https://ducafecat.oss-cn-beijing.aliyuncs.com/wp-content/uploads/2022/04/c-bag.png",
      "name": "c-bag",
      "alt": ""
    },
    "menu_order": 6,
    "count": 1,
    "_links": {
      "self": [
        {
          "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/34"
        }
      ],
      "collection": [
        {
          "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories"
        }
      ]
    }
  }
]
```

生成模型 `json to dart`

lib/common/models/woo/category_model

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_OwZ7fH2iVx.png"  />

### 第 2 步：商品请求

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image-20220720085927887.png"  />

请求模型

lib/common/models/request/product.dart

```dart
/// 商品查询请求
class ProductsReq {
  /// 页码
  final int? page;

  /// 页尺寸
  final int? prePage;

  /// 推荐
  final bool? featured;

  /// 分类
  final String? category;

  /// 关键词
  final String? search;

  /// slug
  final String? slug;

  /// 标签
  final String? tag;

  /// 状态
  final String? status;

  /// sku
  final String? sku;

  /// 属性
  final String? attribute;

  /// 属性 颜色、尺寸 id
  final String? attributeTerm;

  /// 最小价格
  final String? minPrice;

  /// 最大价格
  final String? maxPrice;

  /// 排序方向 desc asc
  final String? order;

  /// 排序字段
  final String? orderby;

  ProductsReq({
    this.page,
    this.prePage,
    this.featured,
    this.category,
    this.search,
    this.slug,
    this.tag,
    this.status,
    this.sku,
    this.attribute,
    this.attributeTerm,
    this.minPrice,
    this.maxPrice,
    this.order,
    this.orderby,
  });

  Map<String, dynamic> toJson() => {
        'page': page ?? 1,
        'pre_page': prePage ?? 10,
        'featured': featured ?? false,
        'category': category ?? "",
        'search': search ?? "",
        'slug': slug ?? "",
        'tag': tag ?? "",
        'status': status ?? "",
        'sku': sku ?? "",
        'attribute': attribute ?? "",
        'attribute_term': attributeTerm ?? "",
        'min_price': minPrice ?? "",
        'max_price': maxPrice ?? "",
        'orderby': orderby ?? "date",
        'order': order ?? "desc",
      };
}

/// 评论查询请求
class ReviewsReq {
  final int? page;
  final int? prePage;
  final int? product;

  ReviewsReq({
    this.page,
    this.prePage,
    this.product,
  });

  Map<String, dynamic> toJson() => {
        'page': page ?? 1,
        'pre_page': prePage ?? 10,
        'product': product ?? 0,
      };
}

/// tags查询请求
class TagsReq {
  final int? page;
  final int? prePage;
  final String? search;
  final String? slug;

  TagsReq({
    this.page,
    this.prePage,
    this.search,
    this.slug,
  });

  Map<String, dynamic> toJson() => {
        'page': page ?? 1,
        'pre_page': prePage ?? 10,
        'search': search ?? "",
        'slug': slug ?? "",
      };
}
```

### 第 3 步：商品返回

数据结构

```json
[
  {
    "id": 15,
    "name": "Beanie",
    "slug": "beanie",
    "permalink": "https://wp.ducafecat.tech/product/beanie/",
    "date_created": "2022-03-31T23:19:37",
    "date_created_gmt": "2022-03-31T15:19:37",
    "date_modified": "2022-04-18T23:50:20",
    "date_modified_gmt": "2022-04-18T15:50:20",
    "type": "simple",
    "status": "publish",
    "featured": true,
    "catalog_visibility": "visible",
    "description": "<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>\n",
    "short_description": "<p>This is a simple product.</p>\n",
    "sku": "woo-beanie",
    "price": "18",
    "regular_price": "20",
    "sale_price": "18",
    "date_on_sale_from": null,
    "date_on_sale_from_gmt": null,
    "date_on_sale_to": null,
    "date_on_sale_to_gmt": null,
    "on_sale": true,
    "purchasable": true,
    "total_sales": 0,
    "virtual": false,
    "downloadable": false,
    "downloads": [],
    "download_limit": 0,
    "download_expiry": 0,
    "external_url": "",
    "button_text": "",
    "tax_status": "taxable",
    "tax_class": "",
    "manage_stock": false,
    "stock_quantity": null,
    "backorders": "no",
    "backorders_allowed": false,
    "backordered": false,
    "low_stock_amount": null,
    "sold_individually": false,
    "weight": "1",
    "dimensions": {
      "length": "12",
      "width": "12",
      "height": "3"
    },
    "shipping_required": true,
    "shipping_taxable": true,
    "shipping_class": "china_shipping",
    "shipping_class_id": 41,
    "reviews_allowed": true,
    "average_rating": "0.00",
    "rating_count": 0,
    "upsell_ids": [],
    "cross_sell_ids": [],
    "parent_id": 0,
    "purchase_note": "",
    "categories": [
      {
        "id": 34,
        "name": "Bag",
        "slug": "bag"
      },
      {
        "id": 29,
        "name": "Man",
        "slug": "man"
      },
      {
        "id": 15,
        "name": "More",
        "slug": "more"
      },
      {
        "id": 30,
        "name": "Woman",
        "slug": "woman"
      }
    ],
    "tags": [
      {
        "id": 42,
        "name": "beanie",
        "slug": "beanie"
      }
    ],
    "images": [
      {
        "id": 44,
        "date_created": "2022-04-01T07:20:01",
        "date_created_gmt": "2022-03-31T15:20:01",
        "date_modified": "2022-04-01T07:20:01",
        "date_modified_gmt": "2022-03-31T15:20:01",
        "src": "https://ducafecat.oss-cn-beijing.aliyuncs.com/wp-content/uploads/2022/03/beanie-2.jpg",
        "name": "beanie-2.jpg",
        "alt": ""
      }
    ],
    "attributes": [
      {
        "id": 1,
        "name": "Color",
        "position": 0,
        "visible": true,
        "variation": false,
        "options": ["Green", "Purple"]
      },
      {
        "id": 2,
        "name": "Size",
        "position": 1,
        "visible": true,
        "variation": false,
        "options": ["XL", "2XL", "3XL"]
      }
    ],
    "default_attributes": [],
    "variations": [],
    "grouped_products": [],
    "menu_order": 0,
    "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><bdi><span class=\"woocommerce-Price-currencySymbol\">&yen;</span>20.00</bdi></span></del> <ins><span class=\"woocommerce-Price-amount amount\"><bdi><span class=\"woocommerce-Price-currencySymbol\">&yen;</span>18.00</bdi></span></ins>",
    "related_ids": [12, 11, 13, 14],
    "meta_data": [
      {
        "id": 89,
        "key": "_original_id",
        "value": "48"
      },
      {
        "id": 479,
        "key": "_wpcom_is_markdown",
        "value": "1"
      }
    ],
    "stock_status": "instock",
    "has_options": false,
    "_links": {
      "self": [
        {
          "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/15"
        }
      ],
      "collection": [
        {
          "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products"
        }
      ]
    }
  }
]
```

生成模型

lib/common/models/woo/product_model

<img src="https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/image_1zb2726027.png" />

lib/common/models/woo/product_model/attribute.dart

```dart
  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        ...
        options: json['options']?.cast<String>(),
```

lib/common/models/woo/product_model/product_model.dart

```dart
factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
  ...
	relatedIds: json['related_ids']?.cast<int>(),
```

### 第 4 步：product api 编写

lib/common/api/product.dart

```dart
import '../index.dart';

/// 商品 api
class ProductApi {
  /// 分类列表
  static Future<List<CategoryModel>> categories() async {
    var res = await WPHttpService.to.get(
      '/products/categories',
    );

    List<CategoryModel> categories = [];
    for (var item in res.data) {
      categories.add(CategoryModel.fromJson(item));
    }
    // 排序 menuOrder , 小号在前
    categories.sort((a, b) => a.menuOrder!.compareTo(b.menuOrder as int));
    return categories;
  }

  /// 商品列表
  static Future<List<ProductModel>> products(ProductsReq? req) async {
    var res = await WPHttpService.to.get(
      '/products',
      params: req?.toJson(),
    );

    List<ProductModel> products = [];
    for (var item in res.data) {
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }
}
```

### 第 5 步：控制器

lib/pages/goods/home/controller.dart

```dart
  // 分类导航数据
  List<CategoryModel> categoryItems = [];
  // 推荐商品列表数据
  List<ProductModel> flashShellProductList = [];
  // 最新商品列表数据
  List<ProductModel> newProductProductList = [];
```

```dart
  _initData() async {
    ...
    // 分类
    categoryItems = await ProductApi.categories();
    // 推荐商品
    flashShellProductList =
        await ProductApi.products(ProductsReq(featured: true));
    // 新商品
    newProductProductList = await ProductApi.products(ProductsReq());

    update(["home"]);
  }
```

> 提交代码到 git

```sh
git add .
git commit -m "9.4 数据模型、API（分类、商品）"
```

