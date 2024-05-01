import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';

class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String hint;
  final Function(List) onSelectedItemsChanged;
  final List<T> selectedItems;
  final Function(T item) itemNameBuilder;
  final Function()? onLoad;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.onSelectedItemsChanged,
    required this.selectedItems,
    required this.itemNameBuilder,
    this.onLoad,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  bool _isExpanded = false;
  List<T> _selectedItems = [];
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
    widget.onLoad?.call();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
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
                            child: Wrap(
                              spacing: 6.0,
                              children: _selectedItems.isEmpty
                                  ? [
                                      Text(widget.hint,
                                          style: context.textStyle.detailText
                                              .copyWith(
                                            color:
                                                context.color.accountInfoColor,
                                          )),
                                    ]
                                  : _selectedItems.map((item) {
                                      return Chip(
                                        label: Text(
                                          widget.itemNameBuilder(item),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        deleteIcon: const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                        ),
                                        onDeleted: () {
                                          setState(() {
                                            _selectedItems.remove(item);
                                            widget.onSelectedItemsChanged(
                                                _selectedItems);
                                          });
                                        },
                                        backgroundColor:
                                            context.color.appThemeMainColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      );
                                    }).toList(),
                            ),
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
                  const SizedBox(height: 8),
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
                      child: ScrollbarTheme(
                        data: ScrollbarThemeData(
                          radius: const Radius.circular(8),
                          mainAxisMargin: 4,
                          thumbColor: MaterialStatePropertyAll(
                              Colors.grey.withOpacity(0.4)),
                        ),
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: scrollController,
                          child: ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: widget.items.length,
                            itemBuilder: (context, index) {
                              final item = widget.items[index];
                              return ListTile(
                                title: Text(widget.itemNameBuilder(item)),
                                trailing: _selectedItems.contains(item)
                                    ? const Icon(
                                        Icons.check_circle,
                                      )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    if (_selectedItems.contains(item)) {
                                      _selectedItems.remove(item);
                                    } else {
                                      _selectedItems.add(item);
                                    }
                                    widget
                                        .onSelectedItemsChanged(_selectedItems);
                                    _isExpanded = false;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
