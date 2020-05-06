import 'package:get_it/get_it.dart';
import 'core/services/api.dart';
import 'core/services/sharing_api.dart';
import 'core/services/notifications_api.dart';
import 'core/services/authentication/authentication_service.dart';
import 'core/services/notifications/push_notification_service.dart';
import 'core/services/navigation/navigation_service.dart';
import 'core/viewmodels/home_model.dart';
import 'core/viewmodels/login_model.dart';
import 'core/viewmodels/register_model.dart';
import 'core/viewmodels/voice_training_model.dart';
import 'core/viewmodels/choose_mode_model.dart';
import 'core/viewmodels/mouth_selection_model.dart';
import 'core/viewmodels/listening_mode_model.dart';
import 'core/viewmodels/collection_model.dart';
import 'core/viewmodels/mouthpack_model.dart';
import 'core/viewmodels/profile_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => SharingApi());
  locator.registerLazySingleton(() => NotificationsApi());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => RegisterModel());
  locator.registerFactory(() => VoiceTrainingModel());
  locator.registerFactory(() => ChooseModeModel());
  locator.registerFactory(() => MouthSelectionModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => ListeningModeModel());
  locator.registerFactory(() => CollectionModel());
  locator.registerFactory(() => MouthpackModel());
  locator.registerFactory(() => ProfileModel());
}
