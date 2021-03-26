import 'package:CHATS/ChatsMain/ui/viewModels/sign_upVM.dart';
import 'package:CHATS/ChatsMain/ui/viewModels/splash_screenVM.dart';
import 'package:get_it/get_it.dart';
import '../providers/base_provider_model.dart';
import '../services/local_storage_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => BaseProviderModel());
  locator.registerFactory(() => SharedPref());
  locator.registerLazySingleton(() => SplashScreenViewModel());
  locator.registerLazySingleton(() => SignUpVM());
}

// LOCATOR FROM BENEFICIARY APP
