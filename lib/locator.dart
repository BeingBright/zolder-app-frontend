import 'package:get_it/get_it.dart';
import 'package:zolder_app_frontend/service/auth-service.dart';



/// Locators to get instances of classes mostly singletons
GetIt locator = GetIt.I;

/// needs to be called at in the main
/// it creates the instances of services
void setupLocators() {
  locator.registerLazySingleton<AuthService>(
        () => AuthService(),
  );
}