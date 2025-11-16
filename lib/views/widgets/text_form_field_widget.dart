// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';



class TextFormFieldWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final String? hintText;
  bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?) validator;

  TextFormFieldWidget({
    required this.controller,
    required this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    super.key,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      obscureText: widget.obscureText,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          overflow: TextOverflow.ellipsis,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff454A4F),
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,

        contentPadding: const EdgeInsets.all(15),
        enabledBorder: outlineInputBorder(
          color: Color(0xffBABABA),
          radius: 10,
          width: 1,
        ),
        focusedBorder: outlineInputBorder(
          color: Color(0xff5F33E1),
          radius: 10,
          width: 1,
        ),
        errorBorder: outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
        focusedErrorBorder: outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
      ),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
    );
  }

  OutlineInputBorder outlineInputBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}