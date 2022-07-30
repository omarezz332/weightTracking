import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/generated/locale_keys.g.dart';
import '../../../../settings/helpers/extensions.dart';
import '../../../../settings/helpers/ui_helpers.dart';
import '../../../domain/core/weight.dart';
import '../../provider/weight_provider/get_weights_notifier.dart';
import '../../provider/weight_provider/weight_state.dart';
import '../dialogs/create_post_dialog.dart';
import '../widgets/custom_loading_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    UiHelpers.postBuildCallback((p0) {
      ref.read(getWeightNotifierProviderRef.notifier).getWeight();

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) => weightWidget();

  Scaffold weightWidget() =>
      Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(LocaleKeys.user_actions_Main.tr()),
        ),
        body: weightList(),
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

  Consumer weightList() => Consumer(builder: (__, ref, _) {
      final state = ref.watch(getWeightNotifierProviderRef);
      return state == const WeightLoading()
          ? const Center(
        child: CustomLoadingWidget(),
      )
          : state is  WeightError
          ? const Center(
        child: Text('Error'),
      )
          : state is GotWeight
          ? state.weights.isEmpty
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "No weights yet",
            style: context.textTheme.headline2,
          ),
        ),
      ):_weightList(state.weights)
          : const SizedBox();
    });

 Widget _weightList(List<Weight> weights) => ListView.builder(
        itemCount: weights.length,
        itemBuilder: (context, index) =>_weightItem(weights[index]),

      );

Card  _weightItem(Weight weight) => Card(
    child: Column(
      children: [
        Text(
          weight.weight.toString(),
          style: context.textTheme.headline2,
        ),
        Text(
          weight.date.toString(),
          style: context.textTheme.headline2,
        ),

      ],
    ),
  );
 }

