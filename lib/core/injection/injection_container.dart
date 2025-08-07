import 'package:get_it/get_it.dart';
import 'package:tap_invest/features/home/data/datasources/home_datasouce_impl.dart';
import 'package:tap_invest/features/home/data/repositories/home_repository_impl.dart';
import 'package:tap_invest/features/home/domain/repositories/abstract_home_datasource.dart';
import 'package:tap_invest/features/home/domain/repositories/abstract_home_repository.dart';
import 'package:tap_invest/features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

void initDependencies() {
  // blocs
  sl.registerFactory(
    () => HomeBloc(homeRepository: sl<AbstractHomeRepository>()),
  );

  // repositories
  sl.registerLazySingleton<AbstractHomeRepository>(
    () => HomeRepositoryImpl(homeDatasource: sl<AbstractHomeDatasource>()),
  );

  // datasources
  sl.registerLazySingleton<AbstractHomeDatasource>(() => HomeDatasouceImpl());
}
