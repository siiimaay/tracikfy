import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;

  const TabView({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.red,
      minVerticalPadding: 5,
      onTap: () {
        onTap.call();
      },
      horizontalTitleGap: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      selected: isSelected,
      selectedColor: Colors.red,
      selectedTileColor: Colors.white,
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
