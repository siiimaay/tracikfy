import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final Icon? prefixIcon;
  final String text;
  final String valueText;
  final VoidCallback? onTap;
  final bool isSwitchSetting;

  const DetailItem(
      {Key? key,
      this.prefixIcon,
      required this.text,
      required this.valueText,
      this.onTap,
      this.isSwitchSetting = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, -5),
              blurRadius: 20,
              //color: context.color.settingsItemShadow.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (prefixIcon != null) prefixIcon!,
            const SizedBox(width: 8),
            Expanded(child: Text(text)),
            Text(valueText)
          ],
        ),
      ),
    );
  }
}
