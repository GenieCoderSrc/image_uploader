# Changelog

All notable changes to this project will be documented in this file.

---

## 0.0.5

### Aug 17, 2025

### ✨ Updated

- Updated `fire_storage_impl` package


## 0.0.4
### Jul 29, 2025

### 🔧 Changed

* Removed all implementation layers except the domain layer for file/image handling to improve decoupling and testability.
* Centralized registration of image upload data source using `registerImageUploaderGetItDi()` with enum `FileUploaderSourceType`.

  * Enables switching between `restApi` and `firebaseStorage` easily.

### 🆕 Added

* Enum `FileUploaderSourceType` for selecting upload strategy.
* `registerImageUploaderGetItDi()` method to abstract the DI setup based on the enum value.

> ✅ Aligns with SOLID principles (especially OCP & SRP) to allow scalable and flexible data source management.

---

## 0.0.3  
### Jul 6, 2025

### 🆕 Added

* Introduced `BaseImageManager<TData>` abstract class to standardize image upload and delete behavior.

  * `uploadIfAvailable(...)` – handles safe upload when file and entityId are provided.
  * `deleteIfAvailable(...)` – handles conditional deletion if a URL is present.
  * Uses `Either<IFailure, bool>` for clean failure handling via `i_tdd` and `exception_type`.
  * Leverages `.handleReport()` for optional success message reporting after operations.

> ✅ Designed with SOLID principles to promote reusability and simplify extending image upload logic across platforms (Firebase, REST, etc).

---

## 0.0.2

### 🆕 Added

* Upload and delete functionality using Firebase Storage.
* Upload and delete functionality using a REST API.
* File model (`FileEntity`, `FileResponseEntity`).
* Repository pattern with `IFileRepository` abstraction.
* Use cases: `UploadFile`, `DeleteFile`.
* Dependency injection setup for both Firebase and REST API.
* Extension on `Uint8List` for uploading to Firebase Storage.
* Example app demonstrating image picking and uploading.

---

## 0.0.1

### 🆕 Initial Release
