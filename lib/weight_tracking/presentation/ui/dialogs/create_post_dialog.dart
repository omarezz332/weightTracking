import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../settings/generated/locale_keys.g.dart';
import '../../../../settings/helpers/extensions.dart';
import '../../../../settings/helpers/fields_validator.dart';
import '../../provider/fields_providers/weight_field_provider.dart';
import '../../provider/weight_provider/authentication_notifier.dart';
import '../../provider/weight_provider/get_weights_notifier.dart';
import '../../provider/weight_provider/weight_state.dart';
import '../../ui/dialogs/dialog_container.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateWeightDialog extends ConsumerStatefulWidget {
  const CreateWeightDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateWeightDialog> createState() => _createPostDialog();
}

class _createPostDialog extends ConsumerState<CreateWeightDialog> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      child: DialogContainer(
        //  title: LocaleKeys.alerts_logout.tr(),
        children: [
          SingleChildScrollView(
            child: Expanded(
              child: Form(
                key: ref.read(weightFieldProviderRef).loginKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Weight",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setSp(10),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(20),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (value) => value!
                          .trim()
                          .validate([ validateRequired]),
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Date",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setSp(10),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(20),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (value) => value!
                          .trim()
                          .validate([validateRequired]),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: context.colorScheme.secondary,
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => AutoRouter.of(context).pop(),
                            child: Text(LocaleKeys.user_actions_ignore.tr()),
                          ),
                        ),
                        Consumer(
                          builder: (_, ref, __) {
                            final fieldProvider = ref.read(weightFieldProviderRef);
                            final loading = ref.watch(addWeightNotifierProvider)
                            is WeightLoading ;
                            return      Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      context.colorScheme.secondary),
                                  textStyle: MaterialStateProperty.all(TextStyle(
                                      color: context.colorScheme.onBackground,
                                      fontSize: 25.sp)),
                                ),
                                onPressed: () async {
                                  if (fieldProvider.validate()) {
                                     await ref.read(addWeightNotifierProvider.notifier).addWeight();
                                        AutoRouter.of(context).pop();
                                    }

                                  },
                                child: loading?SpinKitThreeBounce(
                                  color: context.theme.canvasColor,
                                  size: 20,
                                ):Text(LocaleKeys.user_actions_publish.tr()),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
}

void showLogoutAlertDialog(BuildContext context) =>
    showDialog(context: context, builder: (_) => const CreateWeightDialog());
