// lib/features/register/widgets/_register_login_button.dart

part of '../views/register_view.dart';

class _RegisterLoginButton extends StatelessWidget {
  const _RegisterLoginButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, true); // Close the register view
      },
      child: Text(
        'register.already_have_account'.tr(),
        style: TextStyle(
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
