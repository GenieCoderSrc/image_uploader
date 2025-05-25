import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:image_uploader/domain/repositories/file_repository_rest_api_data_source_impl.dart';
import 'package:image_uploader/domain/repositories/i_repositories/i_file_repository.dart';
import 'package:rest_api_impl/rest_api_impl.dart';

import 'file_use_cases_register_get_it_dI.dart';

void fileRegisterGetItDiRestApiDataSource() {
  // Services
  sl.registerLazySingleton<IImageServiceRestApiDataSource>(
    () => ImageServiceRestApiDataSourceHttpImpl(
      iRestApiConfig: sl(),
      iResponseHandler: sl(),
      iRestApiHeaderProvider: sl(),
      iApiPathUrlGenerator: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<IFileRepository>(
    () => FileRepositoryRestApiDataSourceImpl(iFireStorageService: sl()),
  );

  // register use cases
  fileUseCasesRegisterGetItDI();
}
