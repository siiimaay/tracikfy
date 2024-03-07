import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: const Text(
        "Trackify",
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
