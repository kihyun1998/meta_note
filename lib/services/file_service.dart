import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta_note/utils/snackbar_utils.dart';

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

  File? _selectedFile; // null 일수도 있다.
  String _selectedDirectory = ''; //''으로 초기화

  // 파일 저장 함수
  void saveContent(context) async {
    final String title = titleController.text;
    final String description = descriptionController.text;
    final String memo = memoController.text;

    // 줄바꿈으로 구분된 textContent
    final String textContent =
        "Title:\n\n$title\n\nDescription:\n\n$description\n\nMemo:\n\n$memo";

    // 파일 저장 try catch
    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent); // 문자열 받아서 파일 작성
      } else {
        final today = getTodayDate();
        String metaNotePath = _selectedDirectory;
        if (metaNotePath.isEmpty) {
          // flutter pub add file_picker => for FilePicker
          // 사용자가 폴더 경로 눌러야 한다.
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metaNotePath = directory!; // 경로 저장
          final filePath = '$metaNotePath/$today - $title-memo.txt'; //파일 경로
          final newFile = File(filePath); // 파일 경로의 파일 불러오기
          await newFile.writeAsString(textContent); // 불러온 파일에 text 작성
        }
      }
      SnackBarUtils.showSnackBar(
          context, Icons.check, 'File saved successfully');
    } catch (e) {
      SnackBarUtils.showSnackBar(context, Icons.error, 'File is not saved.');
      debugPrint("[ERROR] : ${e.toString()}");
    }
  }

  static String getTodayDate() {
    final now = DateTime.now();
    // flutter pub add intl => for DateFormat()
    final formatter = DateFormat('yyyy-MM-dd');
    final formatDate = formatter.format(now);
    return formatDate;
  }
}
