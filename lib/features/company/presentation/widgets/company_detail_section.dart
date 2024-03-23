import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';

import 'detail_item.dart';

class CompanyDetailSection extends StatelessWidget {
  final String sectionName;
  final List<DetailItem> settingsItems;

  const CompanyDetailSection({
    Key? key,
    this.sectionName = "",
    required this.settingsItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sectionName.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              sectionName,
              style: context.textStyle.detailText
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ...settingsItems
      ],
    );
  }
}
