part of '../views/login_view.dart';

class _RememberMeAndRegisterWidget extends StatelessWidget {
  final LoginViewModel viewModel;
  final bool rememberMe;

  const _RememberMeAndRegisterWidget({
    required this.viewModel,
    required this.rememberMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: viewModel.toggleRememberMe,
            ),
            Text(
              'login.remember_me'.tr(),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            context.router.push(const RegisterRoute());
          },
          child: Text(
            'login.register'.tr(),
            style: TextStyle(
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
