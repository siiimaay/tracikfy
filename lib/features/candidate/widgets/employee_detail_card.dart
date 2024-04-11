import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import 'employee_label_widget.dart';

class EmployeeDetailCard extends StatelessWidget {
  final String? profilePicturePath;

  const EmployeeDetailCard({super.key,  this.profilePicturePath});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

          isThreeLine: true,
         tileColor: Colors.white,
          titleAlignment: ListTileTitleAlignment.center,
          leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(Assets.images.userAvatar.path),
        ),
          title: const Text("Simay Ekici"),
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Software Engineer"),
            Text("Engineering",style: TextStyle(fontWeight: FontWeight.bold),),
          ],),
          trailing: const EmployeeStatusLabel(),
        ),
      ),
    );
  }
}
