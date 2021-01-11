import 'package:CHATS/ui/viewModels/sign_upVM.dart';
import 'package:CHATS/ui/viewModels/splash_screenVM.dart';
import 'package:get_it/get_it.dart';

import 'core/providerModels/base_provider_model.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => BaseProviderModel());
  locator.registerFactory(() => SharedPref());
  locator.registerLazySingleton(() => SplashScreenViewModel());
  locator.registerLazySingleton(() => SignUpVM());
}
