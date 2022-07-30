import 'dart:developer';


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/helpers/extensions.dart';
import '../../../../settings/router/custom_router.gr.dart';
import '../../provider/authentication_provider/authentication_notifier.dart';
import '../../provider/token_repository_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigateToScreen();
  }

  Future<void> navigateToScreen() async {
    await ref.read(authenticationNotifierProvider.notifier).init();
    Future.delayed(const Duration(seconds: 2), () {
      final bool hasToken= ref.read(tokenRepositoryProvider).hasToken;
      log("hasToken: $hasToken");
      AutoRouter.of(context).pushAndPopUntil(
        hasToken ? const HomeRoute() : const AuthRoute(),
        predicate: (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Container(
      height: context.height,
      width: context.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/splash_background.png",
          ),
          fit: BoxFit.fill,
        ),
      ),

    );
}
