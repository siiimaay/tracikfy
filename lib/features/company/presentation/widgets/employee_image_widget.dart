import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class EmployeeInfoWidget extends StatelessWidget {
  final String? name;

  const EmployeeInfoWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 28,
          width: 28,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(Assets.images.userAvatar.path),
          ),
        ),
        if (name != null) Text(name!),
      ],
    );
  }
}
