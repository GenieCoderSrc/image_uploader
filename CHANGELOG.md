# Changelog

All notable changes to this project will be documented in this file.


## 0.0.3 – Jul 6, 2025

### 🆕 Added

* Introduced `BaseImageManager<TData>` abstract class to standardize image upload and delete behavior.
    * `uploadIfAvailable(...)` – handles safe upload when file and entityId are provided.
    * `deleteIfAvailable(...)` – handles conditional deletion if a URL is present.
    * Uses `Either<IFailure, bool>` for clean failure handling via `i_tdd` and `exception_type`.
    * Leverages `.handleReport()` for optional success message reporting after operations.

> ✅ Designed with SOLID principles to promote reusability and simplify extending image upload logic across platforms (Firebase, REST, etc).


## 0.0.2
### Added
* Upload and delete functionality using Firebase Storage.
* Upload and delete functionality using a REST API.
* File model (`FileEntity`, `FileResponseEntity`).
* Repository pattern with `IFileRepository` abstraction.
* Use cases: `UploadFile`, `DeleteFile`.
* Dependency injection setup for both Firebase and REST API.
* Extension on `Uint8List` for uploading to Firebase Storage.
* Example app demonstrating image picking and uploading.


## 0.0.1
- Initial Release

