import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_uploader/image_uploader.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Choose one based on backend implementation
  fileRegisterGetItDIFireStorageDataSource();
  // fileRegisterGetItDiRestApiDataSource();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UploadDemoPage(),
    );
  }
}

class UploadDemoPage extends StatefulWidget {
  const UploadDemoPage({super.key});

  @override
  State<UploadDemoPage> createState() => _UploadDemoPageState();
}

class _UploadDemoPageState extends State<UploadDemoPage> {
  String? uploadedUrl;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      final fileEntity = FileEntity(
        file: file,
        fileName: 'demo_image.jpg',
        path: 'demo_uploads',
        fileType: 'image',
      );

      final uploadFile = sl<UploadFile>();
      final result = await uploadFile(fileEntity);

      result.fold(
            (failure) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $failure')),
        ),
            (url) => setState(() => uploadedUrl = url),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Uploader Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: const Text('Pick & Upload Image'),
            ),
            if (uploadedUrl != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Uploaded Image URL:'),
                    SelectableText(uploadedUrl!),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
