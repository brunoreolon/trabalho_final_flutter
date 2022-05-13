import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {

  final TextEditingController controller;
  final double left;
  final double top;
  final double right;
  final String labelText;
  final TextInputType type;
  final double border;

  const BuildTextField({required this.controller, required this.left, required this.right, required this.top,
    required this.type, required this.labelText, required this.border,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top, right: right),
      child: TextFormField(
        validator: (value) => controller.text.isEmpty ? "Deve ser preenchido!" : null,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border)
          ),
        ),
      ),
    );
  }
}
