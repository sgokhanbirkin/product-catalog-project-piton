import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_project/product/utility/constants/locales.dart';

@immutable
final class ProductLocalization extends EasyLocalization {
  ProductLocalization({
    required super.child,
    super.key,
  }) : super(
          supportedLocales: _supportedLocales,
          path: _translationsPath,
          useOnlyLangCode: true,
        );

  static final List<Locale> _supportedLocales = [
    Locales.tr.locale,
    Locales.en.locale,
  ];

  static const String _translationsPath = 'asset/translations';

  static Future<void> updateLanguage({
    required Locales value,
    required BuildContext context,
  }) =>
      context.setLocale(value.locale);
}
