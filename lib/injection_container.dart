
import 'package:get_it/get_it.dart';
import 'package:selfie/presentation/bloc/image_bloc.dart';

import 'data/datasources/image_local_data_source.dart';
import 'data/repositories/image_repository_impl.dart';
import 'domain/repositories/image_repository.dart';
import 'domain/usecases/get_saved_images_usecase.dart';
import 'domain/usecases/save_image_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => ImageBloc(
      getSavedImagesUseCase: sl(),
      saveImageUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSavedImagesUseCase(sl()));
  sl.registerLazySingleton(() => SaveImageUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources

  sl.registerLazySingleton<ImageLocalDataSource>(
    () => ImageLocalDataSourceImpl(),
  );

}
