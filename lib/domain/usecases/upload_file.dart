import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:image_uploader/domain/entities/file_entity.dart';
import 'package:image_uploader/domain/repositories/i_repositories/i_file_repository.dart';

class UploadFile extends IEitherUseCase<String, FileEntity> {
  final IFileRepository _iFileRepository;

  UploadFile(this._iFileRepository);

  @override
  Future<Either<IFailure, String>> call(FileEntity params) async =>
      _iFileRepository.uploadFile(params);
}
