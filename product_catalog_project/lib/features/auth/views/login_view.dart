import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.replaceAll([HomeRoute()]);
          },
          child: Text('Giriş Yap'),
        ),
      ),
    );
  }
}
