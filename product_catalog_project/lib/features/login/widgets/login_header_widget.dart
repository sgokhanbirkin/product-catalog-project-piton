part of '../views/login_view.dart';

class _LoginHeaderWidget extends StatelessWidget {
  const _LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('login.welcome_back'.tr(), style: context.textTheme.titleLarge),
        SizedBox(height: context.height * 0.01),
        Text(
          'login.login_to_your_account'.tr(),
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
