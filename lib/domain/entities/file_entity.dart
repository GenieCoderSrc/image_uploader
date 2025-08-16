import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final XFile? pickedFile;
  final Uint8List? bytes;

  final String? path;
  final String? fileName;
  final String? mimeType;
  final String? uploadingToastTxt;

  final Map<String, dynamic>? queryParams;
  final String? imgFieldName;
  final String? urlFieldName;
  final String? accessToken;

  const FileEntity({
    this.pickedFile,
    this.bytes,
    this.path,
    this.fileName,
    this.mimeType = 'Images',
    this.uploadingToastTxt,
    this.queryParams,
    this.imgFieldName,
    this.urlFieldName,
    this.accessToken,
  });

  FileEntity copyWith({
    XFile? pickedFile,
    Uint8List? bytes,
    String? path,
    String? fileName,
    String? mimeType,
    String? uploadingToastTxt,
    Map<String, dynamic>? queryParams,
    String? imgFieldName,
    String? urlFieldName,
    String? accessToken,
  }) => FileEntity(
    pickedFile: pickedFile ?? this.pickedFile,
    bytes: bytes ?? this.bytes,
    path: path ?? this.path,
    fileName: fileName ?? this.fileName,
    mimeType: mimeType ?? this.mimeType,
    uploadingToastTxt: uploadingToastTxt ?? this.uploadingToastTxt,
    queryParams: queryParams ?? this.queryParams,
    imgFieldName: imgFieldName ?? this.imgFieldName,
    urlFieldName: urlFieldName ?? this.urlFieldName,
    accessToken: accessToken ?? this.accessToken,
  );

  @override
  List<Object?> get props => [
    pickedFile,
    bytes,
    path,
    fileName,
    mimeType,
    uploadingToastTxt,
    queryParams,
    imgFieldName,
    urlFieldName,
    accessToken,
  ];

  Map<String, dynamic> toJson() => {
    'file': pickedFile,
    'bytes': bytes,
    'path': path,
    'fileName': fileName,
    'mimeType': mimeType,
    'uploadingToastTxt': uploadingToastTxt,
    'queryParams': queryParams,
    'imgFieldName': imgFieldName,
    'urlFieldName': urlFieldName,
    'accessToken': accessToken,
  };
}
