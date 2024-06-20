import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String jobDepartment;
  final String jobType;
  final int positionsAvailable;

  const JobCard({
    Key? key,
    required this.jobTitle,
    required this.company,
    required this.positionsAvailable,
    required this.jobDepartment,
    required this.jobType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Card(
        color: Colors.white,
        surfaceTintColor:  Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobDepartment,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Text(
                jobTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              Text(
                'Positions Available: $positionsAvailable',
                style: const TextStyle(color: Colors.black),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      company,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      jobType,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
