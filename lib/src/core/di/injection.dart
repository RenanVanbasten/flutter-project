import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_rvtc/src/features/login/controller/login_controller.dart';
import 'package:movies_flutter_rvtc/src/features/login/data/datasources/login_datasource.dart';
import 'package:movies_flutter_rvtc/src/features/login/data/repositories/login_repository.dart';
import 'package:movies_flutter_rvtc/src/features/movies/controller/movies_controller.dart';
import 'package:movies_flutter_rvtc/src/features/movies/data/datasources/movies_datasource.dart';
import 'package:movies_flutter_rvtc/src/features/movies/data/repositories/movies_repository.dart';


final getIt = GetIt.instance;

void configureDependencies(){
  getIt.registerFactory(() => http.Client());

  getIt.registerFactory(() => LoginDatasource(getIt ()));
  getIt.registerFactory(() => LoginRepository(getIt ()));
  getIt.registerSingleton<LoginController>(LoginController(getIt()));

  getIt.registerFactory(() => MoviesRepository(getIt ()));
  getIt.registerFactory(() => MoviesDatasource(getIt ()));
  getIt.registerSingleton<MoviesController>(MoviesController(getIt(), getIt()));

}