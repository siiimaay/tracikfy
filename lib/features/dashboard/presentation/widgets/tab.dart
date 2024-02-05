import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;
  final Widget? prefix;

  const TabView({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onTap,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4)),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        tileColor: Colors.white,
        minVerticalPadding: 5,
        onTap: () {
          onTap.call();
        },
        leading: prefix,
        horizontalTitleGap: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        selected: true,
        minLeadingWidth: 6,
        selectedColor: isSelected ? const Color(0xff09093b) : Colors.white,
        title: Text(
          text,
          style: TextStyle(
            color: isSelected ? const Color(0xff09093b) : Colors.white,
          ),
        ),
      ),
    );
  }
}
