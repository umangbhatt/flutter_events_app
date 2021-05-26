import 'package:events_app/src/repository/events_repository.dart';
import 'package:events_app/src/services/login_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupLocator(){
  serviceLocator.registerLazySingleton(()=>LoginService());
  serviceLocator.registerLazySingleton(() => EventsRepository());
}