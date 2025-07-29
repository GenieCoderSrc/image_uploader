import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:flutter/foundation.dart';
import 'package:image_core/image_core.dart';
import 'package:image_uploader/domain/entities/file_entity.dart';
import 'package:rest_api_impl/rest_api_impl.dart';

import 'i_repositories/i_file_repository.dart';

class FileRepositoryRestApiDataSourceImpl extends IFileRepository {
  final IImageServiceRestApiDataSource imageService;

  FileRepositoryRestApiDataSourceImpl({required this.imageService});

  @override
  Future<Either<IFailure, bool>> deleteFile(String fileUrl) async {
    try {
      final bool isDeleted = await imageService.deleteFile(endPoint: fileUrl);
      return Right(isDeleted);
    } catch (e, stackTrace) {
      debugPrint(
        'FileRepositoryRestApiDataSourceImpl | deleteFile | error: $e\n$stackTrace',
      );
      return const Left(
        FireStorageFailure(FireStorageFailureType.dataParsingFailure),
      );
    }
  }

  @override
  Future<Either<IFailure, String>> uploadFile(FileEntity fileEntity) async {
    try {
      final XFile? file = fileEntity.pickedFile;
      final String? endPoint = fileEntity.path;

      if (file == null) {
        return const Left(DbFailure(DbFailureType.dataNotFound));
      }

      if (endPoint == null || endPoint.trim().isEmpty) {
        return const Left(DbFailure(DbFailureType.invalidData));
      }

      final String? uploadedUrl = await imageService.uploadFile(
        file: file,
        endPoint: endPoint,
        fileName: fileEntity.fileName,
        queryParams: {},
        // or fileEntity.queryParams if you add support
        imgFieldName: 'image',
        urlFieldName: 'url',
        accessToken: null, // or fileEntity.accessToken if supported
      );

      if (uploadedUrl == null) {
        return const Left(
          FireStorageFailure(FireStorageFailureType.referenceNotFound),
        );
      }

      return Right(uploadedUrl);
    } catch (e, stackTrace) {
      debugPrint(
        'FileRepositoryRestApiDataSourceImpl | uploadFile | error: $e\n$stackTrace',
      );
      return const Left(
        FireStorageFailure(FireStorageFailureType.dataParsingFailure),
      );
    }
  }
}
