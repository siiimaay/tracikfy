import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';

class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String hint;
  final Function(List<T>) onSelectedItemsChanged;
  final List<T> selectedItems;
  final Function(T item) itemNameBuilder;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.onSelectedItemsChanged,
    required this.selectedItems,
    required this.itemNameBuilder,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  bool _isExpanded = false;
  List<T> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
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
                            horizontal: 20.0, vertical: 10),

                        decoration: BoxDecoration(
                          color: context.color.settingsItemBorderColor,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 8.0,
                                children: _selectedItems.isEmpty
                                    ? [
                                        const Text(
                                          "SelectSelectSelectSelectSelectSelect",
                                          style: TextStyle(color: Colors.greenAccent),
                                        ),
                                      ]
                                    : _selectedItems.map((item) {
                                        return Chip(
                                          label: Text(
                                            widget.itemNameBuilder(item),
                                            style:  TextStyle(
                                                color: context.color.appThemeMainColor.withOpacity(0.7),),
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
                                          surfaceTintColor: context.color.appThemeMainColor,
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
                        constraints:
                            const BoxConstraints(maxWidth: 400, minWidth: 400),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListView.builder(
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
                                  widget.onSelectedItemsChanged(_selectedItems);
                                });
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
