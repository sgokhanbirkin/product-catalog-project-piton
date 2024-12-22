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
import '../routes/app_router.dart' as _i629;
import '../service/auth_service.dart' as _i850;
import '../service/logger_service.dart' as _i676;
import '../service/logging_interceptor.dart' as _i527;
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
  gh.singleton<_i850.AuthService>(() => _i850.AuthService());
  gh.singleton<_i676.LoggerService>(() => _i676.LoggerService());
  gh.singleton<_i629.AppRouter>(() => _i629.AppRouter());
  gh.singleton<_i527.LoggingInterceptor>(
      () => _i527.LoggingInterceptor(gh<_i676.LoggerService>()));
  gh.singleton<_i933.ProjectNetworkManager>(() => _i933.ProjectNetworkManager(
        gh<_i850.AuthService>(),
        gh<_i527.LoggingInterceptor>(),
      ));
  gh.factory<_i25.CategoryRepository>(
      () => _i25.CategoryRepository(gh<_i933.ProjectNetworkManager>()));
  gh.factory<_i36.ProductRepository>(() => _i36.ProductRepository(
        gh<_i933.ProjectNetworkManager>(),
        gh<_i25.CategoryRepository>(),
      ));
  return getIt;
}
