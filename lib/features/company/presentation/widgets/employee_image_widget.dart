import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class EmployeeImageWidget extends StatelessWidget {
  const EmployeeImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(Assets.images.userAvatar.path),
      ),
    );
  }
}
