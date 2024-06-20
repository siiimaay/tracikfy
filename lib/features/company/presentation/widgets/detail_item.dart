import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';

class DetailItem extends StatefulWidget {
  final Icon? prefixIcon;
  final String text;
  final String valueText;
  final VoidCallback? onTap;
  final bool isSwitchSetting;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const DetailItem({
    Key? key,
    this.prefixIcon,
    required this.text,
    required this.valueText,
    this.onTap,
    this.isSwitchSetting = false,
    this.textEditingController,
    this.focusNode,
  }) : super(key: key);

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    widget.textEditingController?.text = widget.valueText;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: context.color.settingsItemColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xff09093b), width: 1.6),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -5),
              blurRadius: 20,
              color: context.color.settingsItemShadow.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (widget.prefixIcon != null) widget.prefixIcon!,
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              widget.text,
              style: context.textStyle.detailText
                  .copyWith(color: context.color.accountInfoColor),
            )),
            Expanded(
              child: EditableText(
                controller: widget.textEditingController ??
                    TextEditingController(text: widget.valueText),
                focusNode: focusNode,
                style: context.textStyle.detailText
                    .copyWith(color: const Color(0xff09093b)),
                scrollPadding: EdgeInsets.zero,
                cursorColor: context.color.accountInfoColor,
                backgroundCursorColor: Colors.transparent,
                // onTapOutside: (_) => Focus.of(context).unfocus(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
