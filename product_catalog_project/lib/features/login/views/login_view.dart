// lib/features/auth/views/login_view.dart

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/login/view_models/login_view_model.dart';
import 'package:product_catalog_project/product/widgets/custom_elevated_button.dart';
import 'package:product_catalog_project/product/widgets/custom_logo_widget.dart';
import 'package:product_catalog_project/product/widgets/custom_text_field.dart';

part '../widgets/login_button_widget.dart';
part '../widgets/login_header_widget.dart';
part '../widgets/remember_me_and_register_widget.dart';

@RoutePage()
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider); // Watch state here

    return Scaffold(
      body: SingleChildScrollView(
        padding: context.paddingNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.height * 0.1),
            const LogoWidget(),
            SizedBox(height: context.height * 0.1),
            const _LoginHeaderWidget(),
            SizedBox(height: context.height * 0.1),
            // CustomTextField for Email and Password
            CustomTextField(
              controller: viewModel.emailController,
              label: 'login.email'.tr(),
              hintText: 'john@mail.com',
              errorNotifier: viewModel.emailErrorNotifier,
            ),
            CustomTextField(
              controller: viewModel.passwordController,
              label: 'login.password'.tr(),
              hintText: '******',
              errorNotifier: viewModel.passwordErrorNotifier,
              obscureText: true,
            ),
            // "Remember Me" Checkbox and Register Button
            _RememberMeAndRegisterWidget(
              viewModel: viewModel,
              rememberMe: state.rememberMe,
            ),
            SizedBox(height: context.height * 0.075),
            // Login Button
            _LoginButtonWidget(viewModel: viewModel),
            SizedBox(height: context.width * 0.02),
          ],
        ),
      ),
    );
  }
}
