import 'dart:typed_data';

class UploadFile {
  final Uint8List bytes;
  final String name;
  final String mimeType;

  UploadFile({required this.bytes, required this.name, required this.mimeType});
}
