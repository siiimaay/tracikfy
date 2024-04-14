import 'package:json_annotation/json_annotation.dart';
part 'company.g.dart';
@JsonSerializable()
class Company {
  final String company;
  final String workArea;
  final String phoneNo;

  Company({
    required this.company,
    required this.workArea,
    required this.phoneNo,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
