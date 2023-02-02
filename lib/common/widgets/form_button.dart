import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class FormButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const FormButton({required this.onPressed, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            shadowColor: Colors.redAccent,
            minimumSize: const Size(250, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
          ),
          child: Styles.H5(label, Colors.white));
  }
}