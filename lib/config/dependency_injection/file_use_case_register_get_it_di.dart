import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:image_uploader/domain/usecases/delete_file.dart';
import 'package:image_uploader/domain/usecases/upload_file.dart';

void fileUseCasesRegisterGetItDI() {
  /// ----------------- File Get It DI register ------------------
  // use cases
  sl.registerLazySingleton(() => UploadFile(sl()));
  sl.registerLazySingleton(() => DeleteFile(sl()));
}
