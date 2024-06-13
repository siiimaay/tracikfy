import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackify/core/extensions/date_time_extension.dart';
import 'package:trackify/features/dashboard/app_bar_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:trackify/features/dashboard/presentation/dashboard_cubit.dart';
import 'package:trackify/features/dashboard/presentation/widgets/bottom_bar_widget.dart';
import 'package:trackify/features/dashboard/presentation/widgets/job_card_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../core/injection/locator.dart';
import '../../../core/service/firestore_service.dart';
import '../../meeting/data/interview.dart';
import '../../meeting/presentation/meeting_view.dart';

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
      body: BlocProvider(
        create: (context) => DashboardCubit(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "| Plan for the day",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    StreamBuilder<Object>(
                        stream: getIt
                            .get<FirestoreService>(
                                instanceName: "interview_firestore")
                            .listenFetchRecords(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: (snapshot.data as List<Interview>)
                                        .map(
                                          (interview) => SizedBox(
                                            width: 300,
                                            child: MeetingCard(
                                              time: DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          interview.time!)
                                                  .formatTime(),
                                              title: interview.title,
                                              isInMeetingPage: false,
                                              participantLength:
                                                  interview.employees.length,
                                              description: interview.desc ?? "",
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              : SizedBox();
                        }),
                    EmploymentStatusGauge(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
            const Align(
                alignment: Alignment.bottomCenter, child: BottomBarWidget())
          ],
        ),
      ),
    );
  }
}

class EmploymentStatusGauge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmploymentStatusTile(
                title: 'Current Employee Status',
                total: state.employees.length,
                pointers: [
                  _buildRangePointer(
                      state.employees
                          .where((element) => element.status == "Interviewing")
                          .toList()
                          .length
                          .toDouble(),
                      Colors.pink),
                  _buildRangePointer(5, Colors.purple),
                ],
                details: [
                  _buildStatusDetail('Current Employees', 5, 14, Colors.pink),
                  _buildStatusDetail('Candidate', 19, 4, Colors.purple),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ExpansionTile _buildEmploymentStatusTile({
    required String title,
    required int total,
    required List<GaugePointer> pointers,
    required List<Widget> details,
  }) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      initiallyExpanded: true,
      children: <Widget>[
        Center(
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thicknessUnit: GaugeSizeUnit.factor,
                  thickness: 0.15,
                ),
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.1,
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$total',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                pointers: pointers,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details,
          ),
        ),
      ],
    );
  }

  RangePointer _buildRangePointer(double value, Color color) {
    return RangePointer(
      value: value,
      color: color,
      cornerStyle: CornerStyle.bothCurve,
      width: 0.15,
      sizeUnit: GaugeSizeUnit.factor,
    );
  }

  Widget _buildStatusDetail(
      String label, double percentage, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 16),
          SizedBox(width: 8),
          Text('$label ($percentage%)'),
        ],
      ),
    );
  }
}
