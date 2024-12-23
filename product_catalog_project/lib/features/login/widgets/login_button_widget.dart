part of '../views/login_view.dart';

class _LoginButtonWidget extends StatelessWidget {
  final LoginViewModel viewModel;

  const _LoginButtonWidget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        viewModel.login(context);
      },
      buttonText: Text('login.login'.tr()),
    );
  }
}
