// lib/features/register/widgets/_register_name_field.dart

part of '../views/register_view.dart';

class _RegisterNameField extends StatelessWidget {
  final RegisterViewModel viewModel;

  const _RegisterNameField({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: viewModel.nameController,
          label: 'register.full_name'.tr(),
          hintText: 'John Doe',
          onChanged: (value) => viewModel.nameErrorNotifier.value = null,
        ),
        ValueListenableBuilder<String?>(
          valueListenable: viewModel.nameErrorNotifier,
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
