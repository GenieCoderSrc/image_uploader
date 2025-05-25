import 'package:fire_storage_impl/fire_storage_impl.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:image_uploader/domain/repositories/file_repository_fire_storage_data_source_impl.dart';
import 'package:image_uploader/domain/repositories/i_repositories/i_file_repository.dart';

import 'file_use_cases_register_get_it_dI.dart';

void fileRegisterGetItDIFireStorageDataSource() {
  // Services
  sl.registerLazySingleton<IFireStorageService>(() => FireStorageServiceImpl());

  // Repositories
  sl.registerLazySingleton<IFileRepository>(
          () => FileRepositoryFireStorageDataSourceImpl(iFireStorageService: sl()));

  // register use cases
  fileUseCasesRegisterGetItDI();
}