// lib/core/di/di_config.dart

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/di/di_config.g.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt);
