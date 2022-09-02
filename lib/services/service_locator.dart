import 'package:get_it/get_it.dart';
import 'package:teste_tec3/database/database.dart';
import 'package:teste_tec3/repository/swinfo_repository.dart';

// Localizador de serviço
final getIt = GetIt.instance;

// Registra recursos que posso usar em várias partes do aplicativo
void setupGetIt() {
  // A implementação de DatabaseHelper pode ser alterada facilmente trocando o valor da instância retornada
  getIt.registerLazySingleton<DatabaseHelper>(() => SQLiteDatabaseHelper());
  getIt.registerLazySingleton<SWInfoRepository>(() => SWInfoRepository());
}
