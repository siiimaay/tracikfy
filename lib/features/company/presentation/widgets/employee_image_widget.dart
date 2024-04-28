import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class EmployeeInfoWidget extends StatelessWidget {
  final String? name;

  const EmployeeInfoWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: 28,
                width: 28,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(Assets.images.userAvatar.path),
                ),
              ),
            ),
            if (name != null) Flexible(fit:FlexFit.loose,child: Text(name!)),
          ],
        ),
      ),
    );
  }
}
