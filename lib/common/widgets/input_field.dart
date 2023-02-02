import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscured;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.obscured});

  const InputField.email({
    super.key,
    required this.controller,
    this.label="Email",
    this.hint="Enter valid email ID as abc@gmail.com",
    this.obscured=false});

  const InputField.password({
    super.key,
    required this.controller,
    this.label="Password",
    this.hint="Enter secure password",
    this.obscured=true
});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          obscureText: obscured,
          controller: controller,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: label,
              hintText: hint),
        ),
      );
  }
}