import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:weight_tracker/settings/generated/codegen_loader.g.dart';
import 'package:weight_tracker/settings/helpers/app_shared_prefs.dart';
import 'package:weight_tracker/settings/router/custom_router.gr.dart';
import 'package:weight_tracker/settings/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // custom initial helpers
  await EasyLocalization.ensureInitialized();
  await AppSharedPrefs.ensureInit();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ProviderScope(
        child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale('en')],
          startLocale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          assetLoader: const CodegenLoader(),
          child: const MyApp(),
        ),
      ));

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AppRouter _appRouter =
  AppRouter();
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(414, 736),
        builder: (BuildContext context, Widget? child) => OverlaySupport(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routeInformationParser: _appRouter.defaultRouteParser(),
              routerDelegate: AutoRouterDelegate(_appRouter),
              builder: (BuildContext context, Widget? child) => AppTheme(navigator: child!),
            ),
          ));
}

