import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/index.dart';
import 'index.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({super.key});

  // 5 定义 tag 值，唯一即可
  final String tag = '${Get.arguments['id'] ?? ''} ${UniqueKey()}';

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 6 实例传入 tag
    return _ProductDetailsViewGetX(widget.tag);
  }
}

class _ProductDetailsViewGetX extends GetView<ProductDetailsController> {
  // 1 定义唯一 tag 变量
  final String uniqueTag;

  // 2 接收传入 tag 值
  const _ProductDetailsViewGetX(this.uniqueTag);

  // 3 重写 GetView 属性 tag
  @override
  String? get tag => uniqueTag;

  // 主视图
  Widget _buildView(BuildContext context) {
    return controller.product == null
        ? const PlaceholdWidget() // 占位图
        : <Widget>[
            // 滚动图
            _buildBanner(context),

            // 商品标题
            _buildTitle(context),

            // Tab 栏位
            _buildTabBar(context),

            // TabView 视图
            _buildTabView(),
          ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(),
      id: "product_details",
      // 4 GetBuilder 属性 tag 设置
      tag: tag,
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // 导航
          appBar: mainAppBarWidget(titleString: LocaleKeys.gDetailTitle.tr),
          // 内容
          body: SafeArea(
            child: <Widget>[
              // 主视图
              SmartRefresher(
                controller: controller.mainRefreshController, // 刷新控制器
                onRefresh: controller.onMainRefresh, // 下拉刷新回调
                child: _buildView(context),
              ).expanded(),

              // 底部按钮
              _buildButtons(context),
            ].toColumn(),
          ),
        );
      },
    );
  }

  // 滚动图
  Widget _buildBanner(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      id: "product_banner",
      tag: tag,
      builder: (_) {
        return CarouselWidget(
          // 打开大图预览
          onTap: controller.onGalleryTap,
          // 图片列表
          items: controller.bannerItems,
          // 当前索引
          currentIndex: controller.bannerCurrentIndex,
          // 切换回调
          onPageChanged: controller.onChangeBanner,
          // 高度
          height: 190.w,
          // 指示器圆点
          indicatorCircle: false,
          // 指示器位置
          indicatorAlignment: MainAxisAlignment.start,
          // 指示器颜色
          indicatorColor: context.colors.scheme.secondary,
        );
      },
    ).backgroundColor(context.colors.scheme.surface);
  }

  // 商品标题
  Widget _buildTitle(BuildContext context) {
    return <Widget>[
          // 金额、打分、喜欢
          <Widget>[
            // 金额
            TextWidget.h3("\$ ${controller.product?.price ?? 0}").expanded(),
            // 打分
            IconWidget.icon(
              Icons.star,
              text: "4.5",
              size: 20,
              color: context.colors.scheme.primary,
            ).paddingRight(AppSpace.iconTextMedium),
            // 喜欢
            IconWidget.icon(
              Icons.favorite,
              text: "100+",
              size: 20,
              color: context.colors.scheme.primary,
            ),
          ].toRow(),

          // 次标题
          TextWidget.label(
            controller.product?.shortDescription?.clearHtml ?? "-",
          ),
        ]
        .toColumn(
          // 左对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          // 垂直间距
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
        .paddingAll(AppSpace.page);
  }

  // Tab 栏位
  Widget _buildTabBar(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      tag: tag,
      id: "product_tab",
      builder: (_) {
        return <Widget>[
          _buildTabBarItem(context, LocaleKeys.gDetailTabProduct.tr, 0),
          _buildTabBarItem(context, LocaleKeys.gDetailTabDetails.tr, 1),
          _buildTabBarItem(context, LocaleKeys.gDetailTabReviews.tr, 2),
        ].toRowSpace(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  // Tab 栏位按钮
  Widget _buildTabBarItem(BuildContext context, String textString, int index) {
    return ButtonWidget.outline(
      textString,
      onTap: () => controller.onTapBarTap(index),
      borderRadius: 17,
      borderColor: Colors.transparent,
      textColor: controller.tabIndex == index
          ? context.colors.scheme.onSecondary
          : context.colors.scheme.onPrimaryContainer,
      backgroundColor: controller.tabIndex == index
          ? context.colors.scheme.primary
          : context.colors.scheme.onPrimary,
    ).tight(width: 100.w, height: 35.h);
  }

  // TabView 视图
  Widget _buildTabView() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 0.w),
        child: TabBarView(
          controller: controller.tabController,
          children: [
            // 规格
            TabProductView(uniqueTag: uniqueTag),
            // 详情
            TabDetailView(uniqueTag: uniqueTag),
            // 评论
            TabReviewsView(uniqueTag: uniqueTag),
          ],
        ),
      ),
    );
  }

  // 底部按钮
  Widget _buildButtons(BuildContext context) {
    return <Widget>[
          // 加入购物车
          ButtonWidget.outline(LocaleKeys.gDetailBtnAddCart.tr).expanded(),

          // 间距
          SizedBox(width: AppSpace.iconTextLarge),

          // 立刻购买
          ButtonWidget.primary(LocaleKeys.gDetailBtnBuy.tr).expanded(),
        ]
        .toRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
        .paddingHorizontal(AppSpace.page);
  }
}
