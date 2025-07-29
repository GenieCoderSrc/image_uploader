import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_uploader/image_uploader.dart';

void main() {
  registerImageUploaderGetItDi(
    dataSourceType: DataSourceType.firebaseStorage,
  ); // Or restApi

  runApp(const FileExampleApp());
}

class FileExampleApp extends StatelessWidget {
  const FileExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FileUploadDeleteDemo());
  }
}

class FileUploadDeleteDemo extends StatefulWidget {
  const FileUploadDeleteDemo({super.key});

  @override
  State<FileUploadDeleteDemo> createState() => _FileUploadDeleteDemoState();
}

class _FileUploadDeleteDemoState extends State<FileUploadDeleteDemo> {
  String? uploadedUrl;
  bool isLoading = false;
  String result = '';

  Future<void> _uploadSampleFile() async {
    setState(() {
      isLoading = true;
      result = 'Uploading...';
    });

    // Use a sample file from local system or mock during test
    final sampleFile = File('assets/sample_image.jpg'); // Ensure this exists
    final xFile = XFile(sampleFile.path); // Ensure this exists

    final fileEntity = FileEntity(
      pickedFile: xFile,
      path: '/upload/images',
      fileName: 'sample_image.jpg',
      mimeType: 'image/jpeg',
      uploadingToastTxt: 'Uploading image...',
      queryParams: {'folder': 'test_images'},
      imgFieldName: 'image',
      urlFieldName: 'url',
      accessToken: null,
    );

    final uploadFileUseCase = sl<UploadFile>();
    final response = await uploadFileUseCase(fileEntity);

    setState(() {
      isLoading = false;
      response.fold(
        (failure) => result = 'Upload failed: ${failure.toString()}',
        (url) {
          uploadedUrl = url;
          result = 'Upload successful! URL: $url';
        },
      );
    });
  }

  Future<void> _deleteUploadedFile() async {
    if (uploadedUrl == null) {
      setState(() => result = 'No file uploaded to delete.');
      return;
    }

    setState(() {
      isLoading = true;
      result = 'Deleting...';
    });

    final deleteFileUseCase = sl<DeleteFile>();
    final response = await deleteFileUseCase(uploadedUrl!);

    setState(() {
      isLoading = false;
      response.fold(
        (failure) => result = 'Delete failed: ${failure.toString()}',
        (success) {
          uploadedUrl = null;
          result = success ? 'Delete successful!' : 'Delete failed.';
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Upload & Delete Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: isLoading ? null : _uploadSampleFile,
              icon: const Icon(Icons.upload),
              label: const Text('Upload File'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: isLoading ? null : _deleteUploadedFile,
              icon: const Icon(Icons.delete),
              label: const Text('Delete Uploaded File'),
            ),
            const SizedBox(height: 24),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading) Text(result),
          ],
        ),
      ),
    );
  }
}
