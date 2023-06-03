import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.obscureText = false,
      required this.textInputType});
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: obscureText,
    );
  }
}
