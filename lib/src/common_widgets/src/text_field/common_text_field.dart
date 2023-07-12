import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({super.key, this.hintText,});
  final String? hintText;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: TextField(
        style: TextStyle(color: Colors.grey.shade500),
        decoration: InputDecoration(
            fillColor: Colors.white,
            border: InputBorder.none,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500)),
      ),
    );
  }
}
