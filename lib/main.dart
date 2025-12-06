// ignore_for_file: dead_code

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_woo2025/common/index.dart';
import 'package:flutter_woo2025/global.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      splitScreenMode: false,
      minTextAdapt: false,
      builder: (context, child) => AdaptiveTheme(
        light: AppTheme.light,
        dark: AppTheme.dark,
        initial: ConfigService.to.themeMode,
        debugShowFloatingThemeButton: true,

        //构建
        builder: (theme, darkTheme) => RefreshConfiguration(
          headerBuilder: () => const ClassicHeader(), // 自定义刷新头部
          footerBuilder: () => const ClassicFooter(), // 自定义刷新尾部
          hideFooterWhenNotFull: true, // 当列表不满一页时,是否隐藏刷新尾部
          headerTriggerDistance: 80, // 触发刷新的距离
          maxOverScrollExtent: 100, // 最大的拖动距离
          footerTriggerDistance: 150, // 触发加载的距离
          child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            darkTheme: darkTheme,
            initialRoute: RouteNames.systemSplash,
            getPages: RoutePages.list,
            navigatorObservers: [RoutePages.observer],
            themeMode: ThemeMode.system,
            translations: Translation(),
            localizationsDelegates: Translation.localizationsDelegates,
            supportedLocales: Translation.supportedLocales,
            locale: ConfigService.to.locale,
            fallbackLocale: Translation.fallbackLocale,
            builder: (context, widget) {
              widget = EasyLoading.init()(context, widget);
              final data = MediaQuery.maybeOf(context);
              return MediaQuery(
                data:
                    data?.copyWith(textScaler: const TextScaler.linear(1.0)) ??
                    MediaQueryData.fromView(View.of(context)),
                child: widget ?? const SizedBox.shrink(),
              );
            },
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
