// lib/features/register/widgets/_register_password_field.dart

part of '../views/register_view.dart';

class _RegisterPasswordField extends StatelessWidget {
  final RegisterViewModel viewModel;

  const _RegisterPasswordField({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: viewModel.passwordController,
          label: 'register.password'.tr(),
          hintText: '******',
          obscureText: true,
          onChanged: (value) => viewModel.passwordErrorNotifier.value = null,
        ),
        ValueListenableBuilder<String?>(
          valueListenable: viewModel.passwordErrorNotifier,
          builder: (context, error, child) {
            return error != null
                ? Text(error, style: const TextStyle(color: Colors.red))
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
