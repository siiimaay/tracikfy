import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../candidate/data/employee.dart';

class AddMeetingState extends Equatable {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String title;
  final String description;
  final List<String> categories;
  final String selectedCategory;
  final List<Map<String, String>> members;
  final List<String?> employees;

  const AddMeetingState({
    required this.selectedDate,
    required this.selectedTime,
    required this.title,
    required this.description,
    required this.categories,
    required this.members,
    this.selectedCategory = "",
    this.employees = const [],
  });

  AddMeetingState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? title,
    String? description,
    String? selectedCategory,
    List<String>? categories,
    List<Map<String, String>>? members,
    List<String?>? employees,
  }) {
    return AddMeetingState(
        selectedDate: selectedDate ?? this.selectedDate,
        selectedTime: selectedTime ?? this.selectedTime,
        title: title ?? this.title,
        description: description ?? this.description,
        categories: categories ?? this.categories,
        members: members ?? this.members,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        employees: employees ?? this.employees);
  }

  @override
  List<Object?> get props => [
        selectedDate,
        selectedTime,
        title,
        description,
        categories,
        members,
        selectedCategory,
        employees
      ];
}
