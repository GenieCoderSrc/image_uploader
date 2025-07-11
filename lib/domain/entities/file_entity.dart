import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final File? file;
  final Uint8List? bytes;

  final String? path;
  final String? fileName;
  final String? mimeType;
  final String? uploadingToastTxt;

  const FileEntity({
    this.file,
    this.bytes,
    this.fileName,
    this.path,
    this.mimeType = 'Images',
    this.uploadingToastTxt,
  });

  FileEntity copyWith({
    File? file,
    Uint8List? bytes,
    String? collectionPath,
    String? fileName,
    String? fileType,
    String? uploadingToastTxt,
  }) => FileEntity(
    file: file ?? this.file,
    bytes: bytes ?? this.bytes,
    path: collectionPath ?? path,
    fileName: fileName ?? this.fileName,
    mimeType: fileType ?? this.mimeType,
    uploadingToastTxt: uploadingToastTxt ?? this.uploadingToastTxt,
  );

  @override
  List<Object?> get props => [
    file,
    bytes,
    path,
    fileName,
    mimeType,
    uploadingToastTxt,
  ];

  Map<String, dynamic> toJson() => {
    'file': file,
    'bytes': bytes,
    'path': path,
    'fileName': fileName,
    'fileType': mimeType,
    'uploadingToastTxt': uploadingToastTxt,
  };
}
