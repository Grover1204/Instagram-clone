import 'package:flutter/material.dart';

class TextfieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextfieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.isPass=false,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.all(Radius.circular(10)));
    return TextField(

      controller: textEditingController,
      decoration: InputDecoration(

        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
