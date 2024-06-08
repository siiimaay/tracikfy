import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../candidate/data/employee.dart';

part 'interview.g.dart';

@JsonSerializable()
class Interview {
  final String title;
  final int? time;
  final List<dynamic> employees;
  final String category;
  final String? desc;
  final String? userId;

  Interview({
    required this.title,
    required this.time,
    required this.employees,
     this.userId,
    this.category = "",
    this.desc,
  });

  factory Interview.fromJson(Map<String, dynamic> json) =>
      _$InterviewFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewToJson(this);
}
