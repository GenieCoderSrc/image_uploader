import 'package:image_uploader/image_uploader.dart';

/// Register file/image uploader dependencies based on selected source type
void registerImageUploaderGetItDi({
  DataSourceType dataSourceType = DataSourceType.firebaseStorage,
}) {
  switch (dataSourceType) {
    case DataSourceType.restApi:
      fileRegisterGetItDiRestApiDataSource();
      break;
    case DataSourceType.firebaseStorage:
      fileRegisterGetItDIFireStorageDataSource();
      break;
  }
}
