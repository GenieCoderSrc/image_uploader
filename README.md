# image\_uploader

`image_uploader` is a modular and extensible Dart package that simplifies file upload and deletion processes using either Firebase Storage or a REST API-based service. Built with dependency injection and clean architecture principles, this package is designed to integrate easily into your Flutter backend logic.

---

## Features

* Upload files to Firebase Storage or a REST API.
* Delete files from Firebase Storage or REST API.
* Encapsulated `FileEntity` and `FileResponseEntity` models.
* Extension on `Uint8List` to upload image bytes to Firebase Storage.
* Clean separation of concerns via repositories and services.
* Plug-and-play registration using `get_it`.

---

## Getting Started

### Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  image_uploader: <latest_version>
```

---

## Usage

### Dependency Injection Setup

Choose your data source:

#### Firebase Storage

```dart
fileRegisterGetItDIFireStorageDataSource();
```

#### REST API

```dart
fileRegisterGetItDiRestApiDataSource();
```

### Use Cases

```dart
final uploadFile = sl<UploadFile>();
final deleteFile = sl<DeleteFile>();

final fileEntity = FileEntity(
  file: file,
  fileName: 'example.jpg',
  fileType: 'image',
  path: 'user_uploads',
);

final result = await uploadFile(fileEntity);
```

### Upload Uint8List directly to Firebase

```dart
final Uint8List imageBytes = ...
final url = await imageBytes.uploadToFirebaseStorage(
  fileName: 'image.jpg',
  collectionPath: 'uploads',
);
```

---

## Models

### FileEntity

```dart
class FileEntity {
  final File file;
  final String? path;
  final String? fileName;
  final String? fileType;
  final String? uploadingToastTxt;
}
```

### FileResponseEntity

```dart
class FileResponseEntity {
  final String? fileName;
  final String? imgUrl;
}
```

---

## Interfaces

### IFileRepository

```dart
abstract class IFileRepository {
  Future<Either<IFailure, String>> uploadFile(FileEntity fileEntity);
  Future<Either<IFailure, bool>> deleteFile(String imgUrl);
}
```

---

## Customization

Implement your own `IFileRepository`, `IFireStorageService`, or `IImageServiceRestApiDataSource` to customize how uploading/deleting is handled.

---

## Requirements

* Firebase setup (if using Firebase Storage)
* `get_it` for dependency injection

---

## License

MIT License. See `LICENSE` file for details.

---

## Maintainers

Maintained by Shohidul Islam. Contributions welcome!
