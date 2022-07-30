import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/generated/locale_keys.g.dart';
import '../../../../settings/helpers/extensions.dart';
import '../../../domain/core/weight.dart';
import '../dialogs/create_post_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) => weightWidget();

  Scaffold weightWidget() => Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(LocaleKeys.user_actions_Main.tr()),
      ),
      body: Container(),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const CreateWeightDialog(),
        );
      },
      tooltip: LocaleKeys.user_actions_publish.tr(),
      child: const Icon(Icons.add),
    ),
    );

}
