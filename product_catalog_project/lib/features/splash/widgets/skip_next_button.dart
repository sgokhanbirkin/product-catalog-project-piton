part of '../views/splash_view.dart';

class _SkipTextButton extends StatelessWidget {
  final BuildContext context;
  final WidgetRef ref;

  const _SkipTextButton({
    Key? key,
    required this.context,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.router.replace(const HomeRoute());
      },
      child: Text(
        'splash.skip'.tr(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
        ),
      ),
    );
  }
}
