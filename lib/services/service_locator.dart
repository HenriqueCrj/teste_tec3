import 'package:get_it/get_it.dart';
import 'package:teste_tec3/database/database.dart';
import 'package:teste_tec3/pages/home_page/controller.dart';

// Localizador de serviço
final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<HomePageController>(() => HomePageController());
  // Um DatabaseHelper pode ser usado em qualquer lugar no app
  // A implementação pode ser alterada facilmente trocando o valor da instância retornada
  getIt.registerLazySingleton<DatabaseHelper>(() => SQLiteDatabaseHelper());
}
