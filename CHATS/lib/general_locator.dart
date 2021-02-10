import 'package:CHATS/generalSplashScreenVM.dart';
import 'package:CHATS/general_base_provider_model.dart';
import 'package:CHATS/general_sharedPref.dart';
import 'package:get_it/get_it.dart';

GetIt newLocator = GetIt.instance;

void newSetUpLocator() {
  newLocator.registerLazySingleton(() => GBaseProviderModel());
  newLocator.registerFactory(() => GSharedPref());
  newLocator.registerLazySingleton(() => GSplashScreenViewModel());
}
