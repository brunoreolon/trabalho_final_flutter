import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final Alignment alignmentLabel;
  final TextAlign alignmentText;
  final String label;
  final String valor;
  final double left;
  final double top;
  final double right;
  final double bottom;

  const CustomText(this.left, this.top, this.right, this.bottom, {
    required this.alignmentLabel, required this.alignmentText, required this.label, required this.valor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: alignmentLabel,
            child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(valor, textAlign: alignmentText, style: const TextStyle(fontSize: 22))
          )
        ],
      ),
    );
  }
}