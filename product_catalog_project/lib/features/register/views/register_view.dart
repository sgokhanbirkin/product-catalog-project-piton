// lib/features/register/views/register_view.dart

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/features/register/view_models/register_view_model.dart';
import 'package:product_catalog_project/product/widgets/custom_elevated_button.dart';
import 'package:product_catalog_project/product/widgets/custom_logo_widget.dart';
import 'package:product_catalog_project/product/widgets/custom_text_field.dart';

part '../widgets/register_name_field.dart';
part '../widgets/register_email_field.dart';
part '../widgets/register_password_field.dart';
part '../widgets/register_button.dart';
part '../widgets/register_login_button.dart';

@RoutePage()
class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(registerViewModelProvider.notifier);
    final state = ref.watch(registerViewModelProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: context.paddingNormal,
        child: Column(
          children: [
            SizedBox(height: context.height * 0.1),
            const LogoWidget(),
            SizedBox(height: context.height * 0.1),
            Text('register.welcome'.tr(), style: context.textTheme.bodyLarge),
            SizedBox(height: context.height * 0.05),

            // Name Field
            _RegisterNameField(viewModel: viewModel),

            // Email Field
            _RegisterEmailField(viewModel: viewModel),

            // Password Field
            _RegisterPasswordField(viewModel: viewModel),

            SizedBox(height: context.height * 0.05),

            // Register Button
            _RegisterButton(viewModel: viewModel, context: context),

            SizedBox(height: context.height * 0.02),

            // Already have an account? Login button
            const _RegisterLoginButton(),
          ],
        ),
      ),
    );
  }
}
