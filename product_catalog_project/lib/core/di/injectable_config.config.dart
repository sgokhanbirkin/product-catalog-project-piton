// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../repository/category_repository.dart' as _i25;
import '../repository/product_repository.dart' as _i36;
import '../service/project_network_manager.dart' as _i933;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i933.ProjectNetworkManager>(
      () => _i933.ProjectNetworkManager());
  gh.factory<_i25.CategoryRepository>(
      () => _i25.CategoryRepository(gh<_i933.ProjectNetworkManager>()));
  gh.factory<_i36.ProductRepository>(() => _i36.ProductRepository(
        gh<_i933.ProjectNetworkManager>(),
        gh<_i25.CategoryRepository>(),
      ));
  return getIt;
}
