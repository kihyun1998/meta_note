import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta_note/utils/app_styles.dart';

class CustomTextField extends StatefulWidget {
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.maxLength,
    this.maxLines,
    required this.hintText,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();

  // free 해주는거랑 비슷한 느낌인가?
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyText(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: widget.controller, // widget을 사용하면 위젯 정보 가져올 수 있다.
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.accent,
      style: AppTheme.textStyle20,
      decoration: InputDecoration(
          hintStyle: AppTheme.hintStyle,
          hintText: widget.hintText,
          suffixIcon: _copyButton(context),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.accent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.medium,
            ),
          ),
          counterStyle: AppTheme.counterStyle),
    );
  }

  IconButton _copyButton(BuildContext context) {
    return IconButton(
      onPressed: widget.controller.text.isNotEmpty
          ? () => copyText(context, widget.controller.text)
          : null,
      splashRadius: 20,
      splashColor: AppTheme.splash,
      disabledColor: AppTheme.medium,
      icon: const Icon(
        Icons.content_copy_rounded,
        color: AppTheme.accent,
      ),
    );
  }
}
