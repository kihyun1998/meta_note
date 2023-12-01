import "package:flutter/material.dart";
import "package:meta_note/services/file_service.dart";
import "package:meta_note/utils/app_styles.dart";
import "package:meta_note/widgets/custom_textfield.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    addListners();
  }

  @override
  void dispose() {
    removeListners();
    super.dispose();
  }

  void removeListners() {
    for (TextEditingController controller in fileService.controllers) {
      controller.dispose();
    }
  }

  // TextEditingController들을 Listner에 추가
  void addListners() {
    for (TextEditingController controller in fileService.controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  // 필드의 텍스트가 변경된다면 감지해서 setState
  void _onFieldChanged() {
    setState(() {
      fileService.fieldsNotEmpty =
          fileService.titleController.text.isNotEmpty &&
              fileService.descriptionController.text.isNotEmpty &&
              fileService.memoController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => null, 'New File'),
                Row(
                  children: [
                    _actionButton(
                      () => fileService.loadFile(context),
                      Icons.file_upload,
                    ),
                    const SizedBox(width: 8),
                    _actionButton(() => null, Icons.folder),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              maxLength: 100,
              maxLines: 2,
              hintText: 'Enter Title',
              controller: fileService.titleController,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              maxLength: 500,
              maxLines: 3,
              hintText: 'Enter Memo Description',
              controller: fileService.descriptionController,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              maxLength: 3000,
              maxLines: 7,
              hintText: 'Enter Memo',
              controller: fileService.memoController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                _mainButton(
                    fileService.fieldsNotEmpty
                        ? () => fileService.saveContent(context)
                        : null,
                    'Save File'),
              ],
            ),
          ],
        ),
      ),
    );
  }

// _mainButton 기본적인 메인 버튼 위젯
// onPressed : 눌렀을 때 동작하는 함수
// text : 표시될 문자열
  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

// _actionButton 아이콘 버튼 위젯
// onPressed : 눌렀을 때 동작하는 함수
// icon : Icons. 으로 값을 받는다.
  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      splashColor: AppTheme.splash,
      icon: Icon(icon),
      color: AppTheme.medium,
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
