import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trackify/features/dashboard/app_bar_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:trackify/features/dashboard/presentation/widgets/bottom_bar_widget.dart';
import 'package:trackify/features/dashboard/presentation/widgets/job_card_widget.dart';

class DashboardView extends StatelessWidget {
  final Widget? child;
  static const route = "/dashboard";

  const DashboardView({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ??
        AppBarWrapper(
          child: const HRDashboard(),
        );
  }
}

class HRDashboard extends StatelessWidget {
  const HRDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jobs',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // Number of jobs
                    itemBuilder: (context, index) {
                      return const JobCard(
                        jobTitle: 'Software Engineer',
                        company: 'Full time',
                        positionsAvailable: 5,
                        jobDepartment: 'Design',
                        jobType: "",
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32.0),
                Text(
                  "Today\'s Interview Schedule",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                    child: const InterviewScheduleCard(
                  interviewees: [],
                )),
                /*
                const SizedBox(height: 16.0),
                const Text(
                  'To-Do List',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3, // Number of to-dos
                    itemBuilder: (context, index) {
                      return TodoCard(index: index);
                    },
                  ),
                ),*/
              ],
            ),
          ),
          const Align(
              alignment: Alignment.bottomCenter, child: BottomBarWidget())
        ],
      ),
    );
  }
}

class InterviewScheduleCard extends StatelessWidget {
  final List<String> interviewees;

  const InterviewScheduleCard({super.key, required this.interviewees});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: interviewees
                  .map((interviewee) => Text(
                        '- $interviewee',
                        style: const TextStyle(color: Colors.black),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final int index;

  const TodoCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          'To-Do ${index + 1}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        subtitle: Text(
          'Description of To-Do ${index + 1}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.check_circle, color: Colors.green),
        onTap: () {
          // Add your onTap logic here
        },
      ),
    );
  }
}
