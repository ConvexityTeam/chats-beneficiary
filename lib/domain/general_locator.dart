import 'package:CHATS/providers/general_base_provider_model.dart';
import 'package:CHATS/domain/general_sharedPref.dart';
import 'package:get_it/get_it.dart';

GetIt newLocator = GetIt.instance;

void newSetUpLocator() {
  newLocator.registerLazySingleton(() => GBaseProviderModel());
  newLocator.registerFactory(() => GSharedPref());
}
