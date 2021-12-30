import 'package:cawaf_api/cawaf_api.dart';
import 'package:get_it/get_it.dart';
import 'package:vac_card/app/data/authentication/services/remote/remote_authentication_api.dart';

import 'app/core/utils/context_service.dart';
import 'app/data/authentication/services/authentication.dart';
import 'app/data/authentication/services/local/local_authentication_api.dart';
import 'app/data/data_user/data_user.dart';
import 'app/pages/detail/view.dart';
import 'app/pages/login/view/login_vm.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await initDependency();
}

Future<void> initDependency() async {
  Http http = Http(
      baseUrl:
          'https://consultas-api.carnetvacunacion.minsa.gob.pe/minsa/user');

  sl
    //ViewModels
    ..registerFactory(() => DetailViewModel())
    ..registerFactory(() => LoginViewModel())
    //Repositories
    ..registerLazySingleton<LocalAuthenticationRepository>(
        () => LocalAuthenticationApi())
    ..registerLazySingleton<RemoteDataUserRepository>(
        () => RemoteDataUserApi(sl()))
    ..registerLazySingleton<RemoteAuthenticationRepository>(
        () => RemoteAuthenticationApi(sl()))
    ..registerLazySingleton(() => ContextService())
    ..registerLazySingleton(() => http);
}
