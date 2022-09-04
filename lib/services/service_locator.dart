import 'package:get_it/get_it.dart';
import 'package:teste_tec3/database/database.dart';
import 'package:teste_tec3/repository/avatar_repository.dart';
import 'package:teste_tec3/repository/swinfo_repository.dart';

// Uso um localizador de serviços chamado GetIt

// Registra recursos que posso usar em várias partes do aplicativo
void setupGetIt() {
  // A implementação de DatabaseHelper pode ser alterada facilmente trocando o valor da instância retornada
  GetIt.instance
      .registerLazySingleton<DatabaseHelper>(() => SQLiteDatabaseHelper());
  GetIt.instance
      .registerLazySingleton<SWInfoRepository>(() => SWInfoRepository());
  GetIt.instance
      .registerLazySingleton<AvatarRepository>(() => AvatarRepository());
}
