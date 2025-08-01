import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:fire_storage_impl/fire_storage_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:image_core/image_core.dart';
import 'package:image_uploader/domain/entities/file_entity.dart';

import 'i_repositories/i_file_repository.dart';

class FileRepositoryFireStorageDataSourceImpl extends IFileRepository {
  final IFireStorageService iFireStorageService;

  FileRepositoryFireStorageDataSourceImpl({required this.iFireStorageService});

  @override
  Future<Either<IFailure, String>> uploadFile(FileEntity fileEntity) async {
    try {
      UploadFile? uploadFile = await fileEntity.pickedFile
          ?.toUploadFileFromXFile(
            fileName: fileEntity.fileName,
            collectionPath: fileEntity.path,
            uploadingToastTxt: fileEntity.uploadingToastTxt,
          );

      if (uploadFile == null) {
        return const Left<DbFailure, String>(
          DbFailure(DbFailureType.dataNotFound),
        );
      }
      String? imgUrl = await iFireStorageService.uploadFile(
        uploadFile: uploadFile,
      );

      if (imgUrl == null) {
        return const Left<FireStorageFailure, String>(
          FireStorageFailure(FireStorageFailureType.referenceNotFound),
        );
      }
      return Right<IFailure, String>(imgUrl);
    } catch (e) {
      debugPrint(
        'FileRepositoryFireStorageDataSourceImpl | uploadFile | error: $e',
      );
      return const Left<FireStorageFailure, String>(
        FireStorageFailure(FireStorageFailureType.dataParsingFailure),
      );
    }
  }

  @override
  Future<Either<IFailure, bool>> deleteFile(String imgUrl) async {
    try {
      bool isDeleted = await iFireStorageService.deleteFile(imgUrl: imgUrl);

      return Right<IFailure, bool>(isDeleted);
    } catch (e) {
      debugPrint(
        'FileRepositoryFireStorageDataSourceImpl | deleteFile | error: $e',
      );
      return const Left<FireStorageFailure, bool>(
        FireStorageFailure(FireStorageFailureType.dataParsingFailure),
      );
    }
  }
}
