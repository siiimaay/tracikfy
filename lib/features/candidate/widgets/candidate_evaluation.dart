import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:trackify/core/extensions/context_extension.dart';

class LoadingModal extends StatefulWidget {
  @override
  _LoadingModalState createState() => _LoadingModalState();
}

class _LoadingModalState extends State<LoadingModal> with TickerProviderStateMixin {
  bool _isLoading = true;
  double _score = 0;
  String _resultMessage = 'Fetching result...';

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://ec2-18-195-97-43.eu-central-1.compute.amazonaws.com:8000/predict'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, List<String>>{
          'tweets': [
            "Your compassion and empathy make a real difference.",
            "You are valued and appreciated more than you know.",
            "Your positive energy is truly motivating.",
            "You are a beacon of light in a sometimes dark world."
          ],
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          _isLoading = false;
          _resultMessage = jsonResponse['result'];
          _score = 75;
        });
      } else {
        setState(() {
          _isLoading = false;
          _resultMessage = 'Failed to fetch data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _resultMessage = 'Error: $e';
      });
    }
  }

  void _reevaluate() {
    _startLoading();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Cyberbullying evaluation',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: context.color.appThemeMainColor.withOpacity(0.8)
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading ? _buildLoadingAnimation() : _buildScoreDisplay(),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildLoadingAnimation() {
    return Center(
      child: Lottie.asset(
        'assets/animations/rocket.json',
        width: 350,
        height: 350,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildScoreDisplay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                axisLineStyle: const AxisLineStyle(
                  thickness: 10,
                  color:Color(0xff09093b) ,
                  gradient: SweepGradient(
                    colors: [Color(0xff09093b), Color(0xff7787F3)],
                    stops: [0.0, 1.0],
                  ),
                ),
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 100,
                    startWidth: 0.15,
                    endWidth: 0.15,
                    gradient: const SweepGradient(
                      colors: [Color(0xff09093b), Color(0xff7787F3)],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: _resultMessage == "This user is likely not a bully" ?  0 :  90,
                    needleColor: const Color(0xff09093b),
                    knobStyle: const KnobStyle(
                      color: Color(0xff09093b),
                      borderColor: Color(0xff7787F3),
                      borderWidth: 0.05,
                    ),
                  ),
                ],
                annotations: <GaugeAnnotation>[

                  GaugeAnnotation(
                    widget: Container(
                      child: Text(
                        _getScoreText(_score),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.8,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Candidate Score: $_resultMessage',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  }

  String _getScoreText(double score) {
    if (score < 50) {
      return 'Poor';
    } else if (score < 75) {
      return 'Average';
    } else {
      return 'Excellent';
    }
  }
}
