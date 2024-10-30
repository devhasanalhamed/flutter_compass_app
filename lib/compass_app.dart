import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass_app/widgets/compass_view_painter.dart';
import 'package:flutter_compass_app/widgets/neumorphism.dart';

import 'core/global/theme/app_colors/app_colors_light.dart';

class CompassApp extends StatefulWidget {
  const CompassApp({super.key});

  @override
  State<CompassApp> createState() => _CompassAppState();
}

class _CompassAppState extends State<CompassApp> {
  double? direction;
  int updateCount = 0;
  int lastUpdateTime = DateTime.now().millisecondsSinceEpoch;
  double avgUpdateInterval = 0.0;

  double headingToDegree(double heading) {
    return heading < 0 ? 360 - heading.abs() : heading;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((CompassEvent event) {
      setState(() {
        direction = event.heading;
        _updateSensorEfficiency();
      });
    });
  }

  void _updateSensorEfficiency() {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int interval = currentTime - lastUpdateTime;
    lastUpdateTime = currentTime;

    updateCount++;
    avgUpdateInterval =
        ((avgUpdateInterval * (updateCount - 1)) + interval) / updateCount;
  }

  String getSensorEfficiencyStatus() {
    if (avgUpdateInterval < 100) {
      return "Good";
    } else if (avgUpdateInterval < 300) {
      return "Moderate";
    } else {
      return "Poor";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<CompassEvent>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error reading heading");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            direction = snapshot.data?.heading;

            if (direction == null) {
              return const Text("Device does not have sensor");
            }

            final adjustedDirection = headingToDegree(direction!);
            return Stack(
              children: [
                Positioned.fill(
                  top: size.height * 0.1,
                  child: Text(
                    "Sensor Efficiency: ${getSensorEfficiencyStatus()}",
                    style: TextStyle(
                      fontSize: 20,
                      color: getSensorEfficiencyStatus() == "Good"
                          ? Colors.green
                          : getSensorEfficiencyStatus() == "Moderate"
                              ? Colors.orange
                              : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Neumorphism(
                  margin: EdgeInsets.all(size.width * 0.1),
                  padding: const EdgeInsets.all(10.0),
                  child: Transform.rotate(
                    angle: degreesToRadians(adjustedDirection * -1),
                    child: CustomPaint(
                      size: size,
                      painter: CompassViewPainter(color: AppColorsLight.grey),
                    ),
                  ),
                ),
                CenterDisplayMeter(
                  direction: adjustedDirection,
                ),
                Positioned.fill(
                  top: size.height * 0.28,
                  child: Column(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 5,
                              offset: const Offset(10, 10),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 5,
                        height: size.width * 0.21,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 5,
                              offset: const Offset(10, 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CenterDisplayMeter extends StatelessWidget {
  const CenterDisplayMeter({
    super.key,
    required this.direction,
  });

  final double direction;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Neumorphism(
      margin: EdgeInsets.all(size.width * 0.27),
      distance: 2.5,
      blur: 5,
      child: Neumorphism(
        margin: EdgeInsets.all(size.width * 0.01),
        distance: 0,
        blur: 0,
        innerShadow: true,
        isReverse: true,
        child: Neumorphism(
          margin: EdgeInsets.all(size.width * 0.05),
          distance: 4,
          blur: 5,
          child: TopGradientContainer(
            padding: EdgeInsets.all(size.width * 0.02),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColorsLight.greenColor,
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment(-5, -5),
                  end: Alignment.bottomRight,
                  colors: [
                    AppColorsLight.greenDarkColor,
                    AppColorsLight.greenColor,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${direction.toInt().toString().padLeft(3, '0')}°",
                    style: TextStyle(
                      color: AppColorsLight.black,
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getDirection(direction),
                    style: TextStyle(
                      color: AppColorsLight.black,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Function that converts degrees to compass directions like N, NE, etc.
String getDirection(double direction) {
  if (direction >= 337.5 || direction < 22.5) {
    return "N";
  } else if (direction >= 22.5 && direction < 67.5) {
    return "NE";
  } else if (direction >= 67.5 && direction < 112.5) {
    return "E";
  } else if (direction >= 112.5 && direction < 157.5) {
    return "SE";
  } else if (direction >= 157.5 && direction < 202.5) {
    return "S";
  } else if (direction >= 202.5 && direction < 247.5) {
    return "SW";
  } else if (direction >= 247.5 && direction < 292.5) {
    return "W";
  } else if (direction >= 292.5 && direction < 337.5) {
    return "NW";
  } else {
    return "N";
  }
}
