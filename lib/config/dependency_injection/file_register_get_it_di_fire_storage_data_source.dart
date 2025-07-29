import 'package:fire_storage_impl/fire_storage_impl.dart';
import 'package:image_uploader/image_uploader.dart';

void fileRegisterGetItDIFireStorageDataSource() {
  // Services
  sl.registerLazySingleton<IFireStorageService>(() => FireStorageServiceImpl());

  // Repositories
  sl.registerLazySingleton<IFileRepository>(
    () => FileRepositoryFireStorageDataSourceImpl(iFireStorageService: sl()),
  );

  // register use cases
  fileUseCasesRegisterGetItDI();
}
