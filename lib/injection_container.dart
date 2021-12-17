import 'package:cawaf_api/cawaf_api.dart';
import 'package:get_it/get_it.dart';

import 'app/core/utils/context_service.dart';
import 'app/data/data_user/data_user.dart';
import 'app/pages/home/vm/home_vm.dart';

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
    ..registerFactory(() => HomeViewModel())
    //Repositories
    ..registerLazySingleton<RemoteDataUserRepository>(
        () => RemoteDataUserApi(sl()))
    ..registerLazySingleton(() => ContextService())
    ..registerLazySingleton(() => http);
}
