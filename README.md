# image_uploader

`image_uploader` is a modular and extensible Dart package that simplifies file upload and deletion processes using either Firebase Storage or a REST API-based service. Built with dependency injection and clean architecture principles, this package is designed to integrate easily into your Flutter backend logic.

---

## Features

* Upload files to Firebase Storage or a REST API.
* Delete files from Firebase Storage or REST API.
* Encapsulated `FileEntity` and `FileResponseEntity` models.
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

Then run:

```bash
flutter pub get
```

---

## Usage

### Dependency Injection Setup

Choose your data source by passing `ImageUploaderSource` enum to the `fileRegisterGetItDi()` function:

#### Firebase Storage

```dart
fileRegisterGetItDi(ImageUploaderSource.firebase);
```

#### REST API

```dart
fileRegisterGetItDi(ImageUploaderSource.restApi);
```

---

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

---

## Models

### FileEntity

```dart
class FileEntity {
  final File? file;
  final Uint8List? bytes;
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
* `dartz`, `exception_type`, `i_tdd` for result handling and abstractions

---

## License

MIT License. See `LICENSE` file for details.

---

## Maintainers

Developed and Maintained with ❤️ by [Shohidul Islam](https://github.com/ShohidulProgrammer). Contributions welcome!
