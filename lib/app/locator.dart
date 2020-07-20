import 'package:get_it/get_it.dart';
import 'package:shik_i_blisk/caches/preferences.dart';
import 'package:shik_i_blisk/providers/network_provider.dart';
import 'package:shik_i_blisk/ui/home/home_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NetworkProvider());
  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => HomeViewModel());
}
