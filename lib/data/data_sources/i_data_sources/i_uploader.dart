import 'package:flutter/material.dart';


abstract class IUploader {
  Future<UploadResult> upload(UploadFile file);
}
