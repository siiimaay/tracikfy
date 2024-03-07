import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final Color? color;
  final String label;

  const Frame({
    Key? key,
    this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 159,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(label),
          )
        ],
      ),
    );
  }
}
