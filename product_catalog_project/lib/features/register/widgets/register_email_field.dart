// lib/features/register/widgets/_register_email_field.dart

part of '../views/register_view.dart';

class _RegisterEmailField extends StatelessWidget {
  final RegisterViewModel viewModel;

  const _RegisterEmailField({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: viewModel.emailController,
          label: 'register.email'.tr(),
          hintText: 'example@mail.com',
          onChanged: (value) => viewModel.emailErrorNotifier.value = null,
        ),
        ValueListenableBuilder<String?>(
          valueListenable: viewModel.emailErrorNotifier,
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
