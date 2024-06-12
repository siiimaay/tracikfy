import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _isLoading = false;
      _score = 75; // Example score after loading
    });
  }

  void _reevaluate() {
    setState(() {
      _isLoading = true;
    });
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
                    value: _score,
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
                        '$_score',
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
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
            'Candidate Score: $_score',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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