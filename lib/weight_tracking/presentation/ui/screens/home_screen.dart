import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/generated/locale_keys.g.dart';
import '../../../../settings/helpers/extensions.dart';
import '../../../../settings/helpers/sized_boxes.dart';
import '../../../../settings/helpers/ui_helpers.dart';
import '../../../domain/core/weight.dart';
import '../../provider/weight_provider/get_weights_notifier.dart';
import '../../provider/weight_provider/weight_state.dart';
import '../dialogs/create_post_dialog.dart';
import '../dialogs/logout_alert_dialog.dart';
import '../widgets/custom_loading_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    UiHelpers.postBuildCallback((Duration p0) {
      ref.read(getWeightNotifierProviderRef.notifier).getWeight();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => weightWidget();

  Scaffold weightWidget() => Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(LocaleKeys.user_actions_Main.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => const LogoutAlertDialog());
              },
            ),
          ],
        ),
        body: weightList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const CreateWeightDialog(),
            );
          },
          tooltip: LocaleKeys.user_actions_publish.tr(),
          child: const Icon(Icons.add),
        ),
      );

  Consumer weightList() => Consumer(builder: (__, WidgetRef ref, _) {
        final WeightState state = ref.watch(getWeightNotifierProviderRef);
        return state == const WeightLoading()
            ? const Center(
                child: CustomLoadingWidget(),
              )
            : state is WeightError
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
                          )
                        : _weightList(state.weights)
                    : const SizedBox();
      });

  Widget _weightList(List<Weight> weights) {
    weights.sort((Weight a, Weight b) => b.date!.compareTo(a.date!));
    return ListView.builder(
      itemCount: weights.length,
      itemBuilder: (BuildContext context, int index) =>
          _weightItem(weights[index]),
    );
  }

  Card _weightItem(Weight weight) => Card(
        child: Dismissible(
          key: ValueKey(weight),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
          ),
          confirmDismiss: (direction) => showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are You Sure??'),
              content: const Text('Do you want to remove the Weight'),
              actions: [
                OutlinedButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                )
              ],
            ),
          ),
          onDismissed: (direction) {
            ref
                .read(getWeightNotifierProviderRef.notifier)
                .deleteWeight(weight.id!);
          },
          child: Column(
            children: [
              Text(
                "${weight.weight} KG",
                style: context.textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.date_range),
                  kHorizontalSizedBoxSmall,
                  Text(
                    "${weight.date.toString()}",
                    style: context.textTheme.headline2,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
