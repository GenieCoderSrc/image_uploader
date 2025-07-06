import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';

abstract class BaseImageManager<TData> {
  Future<Either<IFailure, bool>> upload(TData imageData);

  Future<Either<IFailure, bool>> delete(String url);

  Future<void> uploadIfAvailable({
    File? file,
    Uint8List? bytes,
    required String? entityId,
    required TData Function(File? file, Uint8List? bytes, String entityId)
    dataBuilder,
    String? successMsg,
  }) async {
    if ((file != null || bytes != null) && entityId != null) {
      final imageData = dataBuilder(file, bytes, entityId);
      final result = await upload(imageData);
      result.handleReport(successMsg: successMsg);
    }
  }

  Future<void> deleteIfAvailable({
    required String? imageUrl,
    String? successMsg,
  }) async {
    if (imageUrl != null) {
      final result = await delete(imageUrl);
      result.handleReport(successMsg: successMsg);
    }
  }
}
