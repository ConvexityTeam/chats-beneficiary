import 'package:CHATS/providers/base_provider_model.dart';
import 'package:CHATS/screens/Home/view_models/splash_screenVM.dart';
import 'package:CHATS/screens/Home/view_models/local_auth_vm.dart';
import 'package:CHATS/services/local_storage_service.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/screens/Home/view_models/sign_upVM.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerFactory<SharedPref>(() => SharedPref());
  locator.registerLazySingleton<BaseProviderModel>(() => BaseProviderModel());
  locator.registerLazySingleton<SplashScreenViewModel>(
      () => SplashScreenViewModel());
  locator.registerLazySingleton<SignUpVM>(() => SignUpVM());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<LocalAuthVM>(() => LocalAuthVM());
}

// LOCATOR FROM BENEFICIARY APP
