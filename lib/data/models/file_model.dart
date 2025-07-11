import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

class FileModel {
  final File? file;
  final Uint8List? bytes;
  final String? fileName;
  final String? fileType;
  final String? collectionPath;
  final String? uploadingToastTxt;

  FileModel({
    this.file,
    this.bytes,
    this.fileName,
    this.fileType,
    this.collectionPath,
    this.uploadingToastTxt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      file: json['file'] != null ? File(json['file']) : null,
      bytes: json['file'] != null ? json['bytes'] : null,
      fileName: json['fileName'],
      fileType: json['fileType'],
      collectionPath: json['collectionPath'],
      uploadingToastTxt: json['uploadingToastTxt'],
    );
  }
}
