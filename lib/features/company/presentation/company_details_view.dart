import 'package:flutter/material.dart';

class CompanyDetailView extends StatelessWidget {
  static const route = "/company_detail_view";

  const CompanyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Details"),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: CircleAvatar(maxRadius: 75,backgroundColor: Colors.grey,))
        ],
      ),
    );
  }
}
