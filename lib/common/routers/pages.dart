import 'package:flutter_woo2025/pages/index.dart';
import 'package:get/get.dart';

import '../../pages/system/main/binding.dart';
import 'names.dart';
import 'observers.dart';

class RoutePages {
  // 历史记录
  static List<String> history = [];
  // 观察者
  static RouteObservers observer = RouteObservers();
  // 列表
  static List<GetPage> list = [
    //购物车
    GetPage(
      name: RouteNames.cartApplyPromoCode,
      page: () => const ApplyPromoCodePage(),
    ),
    GetPage(name: RouteNames.cartBuyDone, page: () => const BuyDonePage()),
    GetPage(name: RouteNames.cartBuyNow, page: () => const BuyNowPage()),
    GetPage(name: RouteNames.cartCartIndex, page: () => const CartIndexPage()),

    //商品
    GetPage(name: RouteNames.goodsCategory, page: () => const CategoryPage()),
    GetPage(name: RouteNames.goodsHome, page: () => const HomePage()),
    GetPage(
      name: RouteNames.goodsProductDetails,
      page: () => ProductDetailsPage(),
    ),
    GetPage(
      name: RouteNames.goodsProductList,
      page: () => const ProductListPage(),
    ),

    //我的
    GetPage(name: RouteNames.myLanguage, page: () => const LanguagePage()),
    GetPage(name: RouteNames.myMyAddress, page: () => const MyAddressPage()),
    GetPage(name: RouteNames.myMyIndex, page: () => const MyIndexPage()),
    GetPage(
      name: RouteNames.myOrderDetails,
      page: () => const OrderDetailsPage(),
    ),
    GetPage(name: RouteNames.myOrderList, page: () => const OrderListPage()),
    GetPage(
      name: RouteNames.myProfileEdit,
      page: () => const ProfileEditPage(),
    ),
    GetPage(name: RouteNames.myTheme, page: () => const ThemePage()),

    //搜索
    GetPage(
      name: RouteNames.searchSearchFilter,
      page: () => const SearchFilterPage(),
    ),
    GetPage(
      name: RouteNames.searchSearchIndex,
      page: () => const SearchIndexPage(),
    ),

    //样式
    GetPage(name: RouteNames.stylesAppbar, page: () => const AppbarPage()),
    GetPage(name: RouteNames.stylesAvatar, page: () => const AvatarPage()),
    GetPage(
      name: RouteNames.stylesBottomSheet,
      page: () => const BottomSheetPage(),
    ),
    GetPage(name: RouteNames.stylesButton, page: () => const ButtonPage()),
    GetPage(name: RouteNames.stylesCard, page: () => const CardPage()),
    GetPage(name: RouteNames.stylesCheckbox, page: () => const CheckboxPage()),
    GetPage(name: RouteNames.stylesColors, page: () => const ColorsPage()),
    GetPage(name: RouteNames.stylesDialog, page: () => const DialogPage()),
    GetPage(name: RouteNames.stylesForm, page: () => const FormPage()),
    GetPage(name: RouteNames.stylesIcon, page: () => const IconPage()),
    GetPage(name: RouteNames.stylesImage, page: () => const ImagePage()),
    GetPage(name: RouteNames.stylesInput, page: () => const InputPage()),
    GetPage(name: RouteNames.stylesListTile, page: () => const ListTilePage()),
    GetPage(name: RouteNames.stylesPopover, page: () => const PopoverPage()),
    GetPage(
      name: RouteNames.stylesRadioGroup,
      page: () => const RadioGroupPage(),
    ),
    GetPage(
      name: RouteNames.stylesStylesIndex,
      page: () => const StylesIndexPage(),
    ),
    GetPage(name: RouteNames.stylesText, page: () => const TextPage()),
    GetPage(name: RouteNames.stylesTextForm, page: () => const TextFormPage()),

    //系统
    GetPage(
      name: RouteNames.systemLogin,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteNames.systemMain, //主页
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(name: RouteNames.systemRegister, page: () => const RegisterPage()),
    GetPage(
      name: RouteNames.systemRegisterPin,
      page: () => const RegisterPinPage(),
    ),
    GetPage(name: RouteNames.systemSplash, page: () => const SplashPage()),
    GetPage(
      name: RouteNames.systemUserAgreement,
      page: () => const UserAgreementPage(),
    ),
    GetPage(name: RouteNames.systemWelcome, page: () => const WelcomePage()),
    GetPage(name: RouteNames.systemMsg, page: () => const MsgPage()),
  ];
}
