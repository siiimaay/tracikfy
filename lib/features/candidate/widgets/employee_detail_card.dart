import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trackify/features/candidate/data/employee_status.dart';
import 'package:trackify/features/candidate/data/employee_ui_model.dart';
import 'package:trackify/features/candidate/employee_view.dart';
import 'package:trackify/features/candidate/widgets/employee_detail_widget.dart';
import 'package:trackify/features/candidate/widgets/existing_employee_detail_view.dart';

import '../../../gen/assets.gen.dart';
import '../data/employee.dart';
import 'employee_label_widget.dart';

class EmployeeDetailCard extends StatelessWidget {
  final String? profilePicturePath;
  final String name;
  final String title;
  final String department;
  final String status;
  final String? companyId;

  const EmployeeDetailCard({
    super.key,
    this.profilePicturePath,
    required this.name,
    required this.title,
    required this.department,
    required this.status,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          isThreeLine: true,
          tileColor: Colors.white,
          titleAlignment: ListTileTitleAlignment.center,
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(Assets.images.userAvatar.path),
          ),
          onTap: () {
            context.push(
                "${CandidateView.route}/${ExistingEmployeeDetailView.route}",
                extra: EmployeeData(
                  name: name,
                  status: status,
                  companyId: companyId,
                  department: department,
                ));
          },
          title: Text(name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(
                department,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: EmployeeStatusLabel(status: status ?? "ACTIVE"),
        ),
      ),
    );
  }
}
