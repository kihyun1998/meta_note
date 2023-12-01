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
          context, Icons.check, 'File saved successfully.');
    } catch (e) {
      SnackBarUtils.showSnackBar(context, Icons.error, 'File is not saved.');
      debugPrint("[ERROR] : ${e.toString()}");
    }
  }

  // 파일 로드 함수
  void loadFile(context) async {
    try {
      // 파일 가져오기 => FilePicker.platform.pickFiles()
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      // 파일을 잘 불러왔다면 (null이 아니라면)
      if (result != null) {
        File file = File(result.files.single.path!); // 파일 경로로 불러오기
        debugPrint(result.files.single.path);
        _selectedFile = file; // selected file 설정

        // 파일 읽기
        final fileContent = await file.readAsString();
        final lines = fileContent.split('\n\n'); // 구분자로 라인 나누기
        // controller.text에 문자열 입력
        titleController.text = lines[1];
        descriptionController.text = lines[3];
        memoController.text = lines[5];

        // 잘 끝났다는 스낵바
        SnackBarUtils.showSnackBar(
            context, Icons.upload_file, 'File uploaded successfully.');
      } else {
        // 파일 선택 실패
        SnackBarUtils.showSnackBar(context, Icons.error, 'No file selected.');
      }
    } catch (e) {
      // 파일 선택 실패
      SnackBarUtils.showSnackBar(context, Icons.error, 'Fails to load file');
      debugPrint("[ERROR] : ${e.toString()}");
    }
  }

  // 새 파일 생성
  void newFile(context) {
    // 기존 선택됐던 파일 초기화 작업
    _selectedFile = null;
    titleController.clear();
    descriptionController.clear();
    memoController.clear();

    SnackBarUtils.showSnackBar(
        context, Icons.file_upload, 'file created successfully.');
  }

  static String getTodayDate() {
    final now = DateTime.now();
    // flutter pub add intl => for DateFormat()
    final formatter = DateFormat('yyyy-MM-dd');
    final formatDate = formatter.format(now);
    return formatDate;
  }
}
