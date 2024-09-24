
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final VoidCallback onTap;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool obscureText; // Added obscureText parameter
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final bool autoValidate;
  bool inputformaters;

  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.onTap,
    required this.keyboardType,
    required this.readOnly,
    this.inputformaters = false,
    this.obscureText =
        false, // Made obscureText parameter optional and default to false
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.autoValidate =
        false, // Added autoValidate parameter with default value false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,

      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      obscureText: obscureText, // Set obscureText property of the TextFormField
      inputFormatters: inputformaters == true
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [
              LowerCaseTextFormatter(),
            ],
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF5F8FA),
        //fillColor: CustomColor.whiteFormField,
        hintText: hintText,
        //hintFadeDuration: Duration(seconds: 8),
        //contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        hintStyle: const TextStyle(
            fontFamily: 'Poppins Regular',
            fontWeight: FontWeight.w400,
            fontSize: 17,
            color: Color(0xffA5A5A5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none
            // borderSide: BorderSide(
            //     color: Color.fromARGB(0, 228, 219, 219),
            //     style: BorderStyle.none)
            ),

        // border: InputBorder.none,

        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon, // Added prefixIcon to the InputDecoration
      ),
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Convert the input to lowercase
    return newValue.copyWith(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
