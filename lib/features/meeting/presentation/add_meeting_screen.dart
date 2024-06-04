import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import '../../../global/multi_select_dropdown.dart';
import 'add_meeting_cubit/add_meeting_cubit.dart';
import 'add_meeting_cubit/add_meeting_state.dart';

class AddMeetingScreen extends StatefulWidget {
  static const route = "new_meeting_screen";

  const AddMeetingScreen({super.key});

  @override
  AddMeetingScreenState createState() => AddMeetingScreenState();
}

class AddMeetingScreenState extends State<AddMeetingScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: context.read<AddMeetingCubit>().state.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      context.read<AddMeetingCubit>().updateDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: context.read<AddMeetingCubit>().state.selectedTime,
    );
    if (picked != null) {
      context.read<AddMeetingCubit>().updateTime(picked);
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Add Meeting',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) => AddMeetingCubit(),
        child: BlocBuilder<AddMeetingCubit, AddMeetingState>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: KeyboardVisibilityBuilder(
                      builder: (context, isVisible) {
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                 controller: ScrollController(),

                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 8.0),
                                              Icon(Icons.calendar_today, color: context.color.appThemeMainColor),
                                              const SizedBox(width: 8.0),
                                              Text(
                                                "${state.selectedDate.toLocal()}".split(' ')[0],
                                                style: const TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    GestureDetector(
                                      onTap: () => _selectTime(context),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 8.0),
                                            Icon(Icons.access_time, color: context.color.appThemeMainColor),
                                            const SizedBox(width: 8.0),
                                            Text(
                                              state.selectedTime.format(context),
                                              style: const TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Title',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    context.read<AddMeetingCubit>().updateTitle(value);
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Team Member',
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: context.color.appThemeMainColor),
                                ),
                                const SizedBox(height: 8.0),
                                MultiSelectDropdown(
                                  items: state.employees.map((e) => e).toList(),
                                  hint: 'Select team members',
                                  onSelectedItemsChanged: (items) {
                                    context.read<AddMeetingCubit>().updateEmployees(items as List<String?>);
                                  },
                                  isReadOnly: false,
                                  selectedItems: [state.members.first["name"]],
                                  itemNameBuilder: (dynamic item) {
                                    return item;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Category',
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: context.color.appThemeMainColor),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: context.read<AddMeetingCubit>().state.categories.map((category) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<AddMeetingCubit>().updateCategory(category);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                                            decoration: BoxDecoration(
                                              color: (state.selectedCategory == category && state.selectedCategory.isNotEmpty) ? const Color(0xff9CA5D9) : Colors.transparent,
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                category,
                                                style: TextStyle(
                                                  color: state.selectedCategory == category ? Colors.white : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: TextFormField(
                                    maxLines: 2,
                                    focusNode: _focusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      context.read<AddMeetingCubit>().updateDescription(value);
                                    },
                                    onTapOutside: (_) => _focusNode.unfocus(),
                                  ),
                                ),
                                 SizedBox(height: 80),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AddMeetingCubit>().saveMeeting();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.color.appThemeMainColor,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Add Meeting',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
