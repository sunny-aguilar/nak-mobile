import 'package:flutter/material.dart';

class FormField extends StatelessWidget {
  const FormField({super.key, required this.ctrl, required this.label, required this.vText});
  final TextEditingController ctrl;
  final String label;
  final String vText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.title),
        labelText: label,
        helperText: '*required'
      ),
      controller: ctrl,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return vText;
        }
        return null;
      },
    );
  }
}