import 'dart:io' as io;
import 'dart:typed_data';

import 'package:dartz/dartz.dart' hide State;
import 'package:exception_type/exception_type.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_uploader/image_uploader.dart';

final sl = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Choose one:
  fileRegisterGetItDIFireStorageDataSource();
  // fileRegisterGetItDiRestApiDataSource();

  sl.registerSingleton<BaseImageManager<FileEntity>>(
    ExampleImageManager(
      uploadFile: sl<UploadFile>(),
      deleteFile: sl<DeleteFile>(),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ImageUploaderExamplePage());
  }
}

class ImageUploaderExamplePage extends StatefulWidget {
  const ImageUploaderExamplePage({super.key});

  @override
  State<ImageUploaderExamplePage> createState() =>
      _ImageUploaderExamplePageState();
}

class _ImageUploaderExamplePageState extends State<ImageUploaderExamplePage> {
  String? uploadedUrl;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final Uint8List bytes = await picked.readAsBytes();
    final io.File? file = kIsWeb ? null : io.File(picked.path);
    const entityId = 'user_001';

    final manager = sl<BaseImageManager<FileEntity>>();

    await manager.uploadIfAvailable(
      file: file,
      bytes: bytes,
      entityId: entityId,
      dataBuilder:
          (file, bytes, id) => FileEntity(
            file: file,
            bytes: bytes,
            fileName: 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
            fileType: 'image',
            path: 'uploads/$id',
          ),
      successMsg: '✅ Upload successful!',
    );

    setState(() => uploadedUrl = 'uploads/$entityId/avatar.jpg');
  }

  Future<void> _deleteImage() async {
    if (uploadedUrl == null) return;

    final manager = sl<BaseImageManager<FileEntity>>();
    await manager.deleteIfAvailable(
      imageUrl: uploadedUrl,
      successMsg: '🗑️ Image deleted',
    );

    setState(() => uploadedUrl = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('image_uploader Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: const Text('Pick & Upload Image'),
            ),
            const SizedBox(height: 16),
            if (uploadedUrl != null) ...[
              const Text('Uploaded:'),
              SelectableText(uploadedUrl!),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _deleteImage,
                child: const Text('Delete Image'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ExampleImageManager extends BaseImageManager<FileEntity> {
  final UploadFile uploadFile;
  final DeleteFile deleteFile;

  ExampleImageManager({required this.uploadFile, required this.deleteFile});

  @override
  Future<Either<IFailure, bool>> upload(FileEntity imageData) async {
    final result = await uploadFile(imageData);
    return result.fold((failure) => Left(failure), (url) {
      debugPrint('✅ Uploaded to: $url');
      return const Right(true);
    });
  }

  @override
  Future<Either<IFailure, bool>> delete(String url) {
    return deleteFile(url);
  }
}
