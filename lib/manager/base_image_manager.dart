import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';

/// Abstract class for handling image management operations.
///
/// [TData] is the generic data model used for image uploading and deletion.
abstract class BaseImageManager<TData> {
  /// Upload the image data to a storage location.
  Future<Either<IFailure, bool>> upload(TData imageData);

  /// Delete an image from the storage by its URL.
  Future<Either<IFailure, bool>> delete(String url);

  /// Uploads image data if it exists and entityId is not null.
  ///
  /// [imageData] is the file-like data that will be uploaded (already built).
  /// [entityId] is the associated ID for linking in storage path.
  /// [dataBuilder] is a builder function that converts a nullable image input to [TData].
  Future<void> uploadIfAvailable({
    required TData? imageData,
    required String? entityId,
    required TData Function(TData imageData, String entityId) dataBuilder,
    String? successMsg,
  }) async {
    if (imageData != null && entityId != null) {
      final builtData = dataBuilder(imageData, entityId);
      final result = await upload(builtData);
      result.handleReport(successMsg: successMsg);
    }
  }

  /// Deletes the image from storage if [imageUrl] is not null.
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
