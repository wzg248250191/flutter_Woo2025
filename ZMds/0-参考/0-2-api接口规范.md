# 3 API 接口规范

> 采用 restful 规范接口设计，设计说明如下

## 请求 url示例

| 操作   | URL         | 说明     |
| ------ | ----------- | -------- |
| post   | /orders     | 新增订单 |
| get    | /orders     | 订单列表 |
| get    | /orders/:id | 订单详情 |
| put    | /orders/:id | 修改订单 |
| delete | /orders/:id | 删除订单 |

## 返回 json示例

- 返回分离列表

```json
[
    {
        "id": 19,
        "name": "Accessories",
        "slug": "accessories",
        "parent": 16,
        "description": "",
        "display": "default",
        "image": null,
        "menu_order": 0,
        "count": 1,
        "_links": {
            "self": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/19"
                }
            ],
            "collection": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories"
                }
            ],
            "up": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/16"
                }
            ]
        }
    },
    {
        "id": 16,
        "name": "Clothing",
        "slug": "clothing",
        "parent": 0,
        "description": "",
        "display": "default",
        "image": null,
        "menu_order": 0,
        "count": 5,
        "_links": {
            "self": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/16"
                }
            ],
            "collection": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories"
                }
            ]
        }
    },
    {
        "id": 21,
        "name": "Decor",
        "slug": "decor",
        "parent": 0,
        "description": "",
        "display": "default",
        "image": null,
        "menu_order": 0,
        "count": 0,
        "_links": {
            "self": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/21"
                }
            ],
            "collection": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories"
                }
            ]
        }
    },
    {
        "id": 18,
        "name": "Hoodies",
        "slug": "hoodies",
        "parent": 16,
        "description": "",
        "display": "default",
        "image": null,
        "menu_order": 0,
        "count": 2,
        "_links": {
            "self": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/18"
                }
            ],
            "collection": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories"
                }
            ],
            "up": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/16"
                }
            ]
        }
    },
    {
        "id": 20,
        "name": "Music",
        "slug": "music",
        "parent": 0,
        "description": "",
        "display": "default",
        "image": null,
        "menu_order": 0,
        "count": 0,
        "_links": {
            "self": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/20"
                }
            ],
            "collection": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories"
                }
            ]
        }
    },
    {
        "id": 17,
        "name": "Tshirts",
        "slug": "tshirts",
        "parent": 16,
        "description": "",
        "display": "default",
        "image": null,
        "menu_order": 0,
        "count": 2,
        "_links": {
            "self": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/17"
                }
            ],
            "collection": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories"
                }
            ],
            "up": [
                {
                    "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/categories/16"
                }
            ]
        }
    }
]
```

- 返回商品详情

```json
{
    "id": 34,
    "name": "Import placeholder for 89",
    "slug": "import-placeholder-for-89",
    "permalink": "https://wp.ducafecat.tech/?post_type=product&p=34",
    "date_created": "2022-03-31T23:19:40",
    "date_created_gmt": "2022-03-31T15:19:40",
    "date_modified": "2022-03-31T23:19:40",
    "date_modified_gmt": "2022-03-31T15:19:40",
    "type": "simple",
    "status": "importing",
    "featured": false,
    "catalog_visibility": "visible",
    "description": "",
    "short_description": "",
    "sku": "wp-pennant",
    "price": "",
    "regular_price": "",
    "sale_price": "",
    "date_on_sale_from": null,
    "date_on_sale_from_gmt": null,
    "date_on_sale_to": null,
    "date_on_sale_to_gmt": null,
    "on_sale": false,
    "purchasable": false,
    "total_sales": 0,
    "virtual": false,
    "downloadable": false,
    "downloads": [],
    "download_limit": -1,
    "download_expiry": -1,
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
    "weight": "",
    "dimensions": {
        "length": "",
        "width": "",
        "height": ""
    },
    "shipping_required": true,
    "shipping_taxable": true,
    "shipping_class": "",
    "shipping_class_id": 0,
    "reviews_allowed": true,
    "average_rating": "0.00",
    "rating_count": 0,
    "upsell_ids": [],
    "cross_sell_ids": [],
    "parent_id": 0,
    "purchase_note": "",
    "categories": [
        {
            "id": 15,
            "name": "Uncategorized",
            "slug": "uncategorized"
        }
    ],
    "tags": [],
    "images": [],
    "attributes": [],
    "default_attributes": [],
    "variations": [],
    "grouped_products": [],
    "menu_order": 0,
    "price_html": "",
    "related_ids": [],
    "meta_data": [
        {
            "id": 412,
            "key": "_original_id",
            "value": "89"
        }
    ],
    "stock_status": "instock",
    "_links": {
        "self": [
            {
                "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products/34"
            }
        ],
        "collection": [
            {
                "href": "https://wp.ducafecat.tech/wp-json/wc/v3/products"
            }
        ]
    }
}
```

## 状态码

| 码   | 说明           |
| ---- | -------------- |
| 200  | 正常返回       |
| 201  | 新建成功       |
| 204  | 删除成功       |
| 400  | 请求错误       |
| 401  | 未认证         |
| 403  | 未授权         |
| 500  | 服务器内部错误 |

> 常用到的状态码

## 密码 AES +Base64对称加密传输

密码在传输过程中很容易被拦截，所以我们进行加密，虽然你用了 ssl

传输的密码 = Base64(AES(你输入的密码))

> 先进行 AES 编码，再进行 Base64 编码后传输

## Authorization Bearer Token + JWT

在每次通讯中加入头信息

```bash
Authorization: "Bearer 你的 jwt token"
```

> 注意这里的 `Bearer` 不要忘记
> 服务器端 `token` 采用 `JWT` 编码，前端无需参与，了解即可

## 错误处理

错误信息采用全局统一的数据格式

```json
{
    "statusCode": 400,
    "error": "registration-error-email-exists",
    "message": "已存在使用此电子邮件地址的帐户"
}
```

> `statusCode` 遵循 http status 标准
> `error` 是一个错误文字标识
> `message` 是错误描述，你可以显示给客户

