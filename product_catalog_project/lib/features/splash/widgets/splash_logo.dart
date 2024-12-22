part of '../views/splash_view.dart';

class _SplashLogo extends StatelessWidget {
  const _SplashLogo({
    required this.assetName,
  });

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        assetName,
      ),
    );
  }
}
