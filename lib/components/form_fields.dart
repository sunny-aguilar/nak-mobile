import 'package:flutter/material.dart';

class SmallFormField extends StatelessWidget {
  const SmallFormField({super.key, required this.ctrl, required this.label, required this.vText});
  final TextEditingController ctrl;
  final String label;
  final String vText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.create_rounded),
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

class ParagraphFormField extends StatelessWidget {
  const ParagraphFormField({super.key, required this.ctrl, required this.label, required this.vText});
  final TextEditingController ctrl;
  final String label;
  final String vText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 5,
      maxLines: 20,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.create_rounded),
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