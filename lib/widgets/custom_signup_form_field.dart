import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final InputDecoration? decoration;
  final String? counterText;

  const SignUpFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.decoration,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      decoration:
          decoration ??
          InputDecoration(
            counterText: counterText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
    );
  }
}
