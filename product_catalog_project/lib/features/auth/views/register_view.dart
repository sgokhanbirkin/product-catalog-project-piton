// lib/features/auth/views/register_view.dart

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';

@RoutePage()
class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.replaceAll([HomeRoute()]);
          },
          child: Text('Kayıt Ol'),
        ),
      ),
    );
  }
}
