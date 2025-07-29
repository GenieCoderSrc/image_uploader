import 'package:image_uploader/image_uploader.dart';
import 'package:rest_api_impl/rest_api_impl.dart';

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
    () => FileRepositoryRestApiDataSourceImpl(imageService: sl()),
  );

  // register use cases
  fileUseCasesRegisterGetItDI();
}
