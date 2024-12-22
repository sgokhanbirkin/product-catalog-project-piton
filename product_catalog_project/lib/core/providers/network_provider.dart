import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';

final projectNetworkManagerProvider = Provider<ProjectNetworkManager>((ref) {
  return GetIt.instance<ProjectNetworkManager>();
});
