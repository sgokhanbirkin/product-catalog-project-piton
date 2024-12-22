// lib/features/register/widgets/_register_button.dart

part of '../views/register_view.dart';

class _RegisterButton extends StatelessWidget {
  final RegisterViewModel viewModel;
  final BuildContext context;

  const _RegisterButton(
      {required this.viewModel, required this.context, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        viewModel.register(context);
      },
      buttonText: 'register.register'.tr(),
    );
  }
}
