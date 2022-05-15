import 'package:flutter/material.dart';

class BuildInputDatePicker extends StatelessWidget {

  final TextEditingController controller;
  final double left;
  final double top;
  final double right;
  final String hintText;
  final double border;

  const BuildInputDatePicker({required this.controller, required this.left, required this.right, required this.top,
    required this.hintText, required this.border,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top, right: right),
      child: TextFormField(
        readOnly: true,
        validator: (value) => controller.text.isEmpty ? "Selecione uma data!" : null,
        controller: controller,
        onTap: () async{
          DateTime? _datePicker = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1990),
              lastDate: DateTime(2030),
              helpText: 'Selecione uma Data!'
          );
          if (_datePicker != null) {
            controller.text = _dateFormated(_datePicker);

          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(border)
          ),
        ),
      ),
    );
  }

  String _dateFormated(DateTime date) {
    return "${date.toLocal().day}/${date.toLocal().month}/${date.toLocal().year}";
  }
}
