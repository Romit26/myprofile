import 'package:flutter/material.dart';
import 'package:myprofile/core/constant/color_constant.dart';

///common custom textField for username,password,name,email,skill and workExperience
class CustomTextField extends StatelessWidget {
  final String hint;
  String? error;
  TextEditingController textEditingController;
  Function(String value) onChange;
  Function(bool value)? onChangeObscure;
  bool obscure;
  bool showSuffix;

  CustomTextField(
      {super.key,
      required this.hint,
      this.obscure = false,
      this.showSuffix = false,
      required this.onChange,
      this.onChangeObscure,
      this.error,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      cursorColor: cursorColor,

      obscureText: obscure,
      decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: Colors.grey.shade200,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          errorText: error,
          errorStyle: const TextStyle(color: Colors.red),
          contentPadding: const EdgeInsets.fromLTRB(10, 25, 25, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: showSuffix
              ? InkWell(
                  onTap: () {
                    obscure = !obscure;
                    onChangeObscure!(obscure);
                  },
                  child: Icon(obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                )
              : null),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}
