import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/attention_seekers/heart_beat.dart';
import 'package:flutter_animator/widgets/bouncing_entrances/bounce_in.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/generated/locale_keys.g.dart';
import '../../../../settings/helpers/extensions.dart';
import '../../../../settings/helpers/fields_validator.dart';
import '../../../../settings/helpers/sized_boxes.dart';
import '../../../../settings/helpers/ui_helpers.dart';
import '../../../../settings/router/custom_router.gr.dart';
import '../../../../settings/theme/dimensions.dart';
import '../../provider/authentication_provider/authentication_notifier.dart';
import '../../provider/authentication_provider/authentication_state.dart';
import '../../provider/fields_providers/login_field_provider.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginFieldProvider fieldProvider = ref.read(loginFieldProviderRef);
    ref.listen<AuthenticationState>(authenticationNotifierProvider,
        (AuthenticationState? previous, AuthenticationState next) {
      if (next is Authenticated && previous != next) {
        UiHelpers.postBuildCallback((Duration p0) {
          Future.delayed(const Duration(milliseconds: 100), () {
            AutoRouter.of(context).pushAndPopUntil(
              const HomeRoute(),
              predicate: (_) => false,
            );
          });
        });
      }
    });
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        backgroundColor: context.colorScheme.background,
        elevation: 0,
        title: Center(
            child: Text(
          LocaleKeys.user_actions_login.tr(),
          style: TextStyle(
            color: context.theme.primaryColor,
          ),
        )),
      ),
      body: BounceIn(

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Form(
              key: fieldProvider.loginKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  CustomTextField(
                    customTextFieldModel: CustomTextFieldModel(
                      validator: (value) => value!
                          .trim()
                          .validate([validateRequired, validateEmail]),
                      textInputType: TextInputType.emailAddress,
                      label: LocaleKeys.user_actions_email.tr(),
                      onSave: (value) => fieldProvider.setEmail(value!.trim()),
                    ),
                  ),
                  CustomTextField(
                    customTextFieldModel: CustomTextFieldModel(
                      isPassword: true,
                      validator: (value) =>
                          value!.validate([validateRequired, validatePassword]),
                      label: LocaleKeys.user_actions_password.tr(),
                      onSave: (value) => fieldProvider.setPassword(value!),
                    ),
                  ),
                  Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final bool loading = ref.watch(authenticationNotifierProvider)
                          is AuthenticationLoading;
                      return CustomElevatedButton(
                        loading: loading,
                        onTap: () {
                          if (fieldProvider.validate()) {
                            ref
                                .read(authenticationNotifierProvider.notifier)
                                .login();
                          }
                        },
                        width: context.widthR(0.5),
                        title: LocaleKeys.user_actions_login.tr().toUpperCase(),
                      );
                    },
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.alerts_do_not_have_account.tr(),
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.theme.dividerColor,
                        ),
                      ),
                      kVerticalSizedBoxMedium,
                      OutlinedButton.icon(
                        onPressed: () =>
                            AutoRouter.of(context).push(const RegisterRoute()),
                        style: ButtonStyle(

                          // backgroundColor: MaterialStateProperty.all<Color>(
                          //   context.theme.colorScheme.secondary,
                          // ),
                          overlayColor: MaterialStateProperty.all<Color>(
                            context.theme.colorScheme.secondary,
                          ),


                          textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(
                            color: Colors.white,
                          )),
                          fixedSize: MaterialStateProperty.all(
                              Size(context.width, 45.h)),
                          side: MaterialStateProperty.all(
                              BorderSide(
                            color: context.theme.colorScheme.secondary,
                            width: 1.w,
                          )),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(kRadiusLarge),

                            ),
                          ),
                        ),
                        label: Text(
                          LocaleKeys.user_actions_register.tr(),
                          style: TextStyle(color: context.theme.colorScheme.secondary),
                        ),
                        icon: Icon(
                          Icons.person_add_outlined,
                          color: context.theme.colorScheme.secondary,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
//widget signup with email and password

}
