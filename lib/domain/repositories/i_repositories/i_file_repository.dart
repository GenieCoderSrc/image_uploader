import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:image_uploader/domain/entities/file_entity.dart';

abstract class IFileRepository {
  Future<Either<IFailure, String>> uploadFile(FileEntity fileEntity);
  Future<Either<IFailure, bool>> deleteFile(String imgUrl);
}
