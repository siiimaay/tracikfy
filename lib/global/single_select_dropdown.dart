import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';

class SingleSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String hint;
  final Function(T?) onSelectedItemChanged;
  final T? selectedItem;
  final Function(T item) itemNameBuilder;
  final Function()? onLoad;

  const SingleSelectDropdown({
    Key? key,
    required this.items,
    required this.hint,
    required this.onSelectedItemChanged,
    required this.selectedItem,
    required this.itemNameBuilder,
    this.onLoad,
  }) : super(key: key);

  @override
  _SingleSelectDropdownState<T> createState() =>
      _SingleSelectDropdownState<T>();
}

class _SingleSelectDropdownState<T> extends State<SingleSelectDropdown<T>> {
  late final ScrollController scrollController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    widget.onLoad?.call();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: context.color.appThemeMainColor, width: 1.6),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                        widget.selectedItem != null
                            ? widget.itemNameBuilder(
                                (widget.selectedItem ?? "Default") as T)
                            : widget.hint,
                        style: context.textStyle.detailText.copyWith(
                          color: context.color.accountInfoColor,
                        )),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
                minWidth: 400,
                minHeight: 60,
                maxHeight: 120,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return ListTile(
                      title: Text(widget.itemNameBuilder(item)),
                      selected: widget.selectedItem == item,
                      onTap: () {
                        setState(() {
                          widget.onSelectedItemChanged(item);
                          _isExpanded = false;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
