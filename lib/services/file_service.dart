import 'package:flutter/material.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  List<TextEditingController> controllers = [];

  FileService() {
    controllers = [
      titleController,
      descriptionController,
      memoController,
    ];
  }

  bool fieldsNotEmpty = false;
}
