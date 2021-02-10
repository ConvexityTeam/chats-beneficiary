// import 'package:CHATS/Chats%20Main/ui/viewModels/sign_upVM.dart';
// import 'package:CHATS/Chats%20Main/ui/viewModels/splash_screenVM.dart';
import 'package:CHATS/Vendor/ui/view_model/sign_upVM.dart';
import 'package:CHATS/Vendor/ui/view_model/splash_screenVM.dart';
import 'package:get_it/get_it.dart';
import 'core/provider_model/base_provider_model.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

void setUpVendorLocator() {
  locator.registerLazySingleton(() => BaseProviderModel());
  locator.registerFactory(() => SharedPref());
  locator.registerLazySingleton(() => SplashScreenViewModel());
  locator.registerLazySingleton(() => SignUpVM());
}
