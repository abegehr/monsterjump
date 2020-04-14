//DEBUG

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class SensorsTest extends StatefulWidget {
  SensorsTest({Key key}) : super(key: key);

  @override
  _SensorsTestState createState() => _SensorsTestState();
}

class _SensorsTestState extends State<SensorsTest> {
  AccelerometerEvent accelerometerEvent;
  UserAccelerometerEvent userAccelerometerEvent;
  GyroscopeEvent gyroscopeEvent;
  GyroscopeEvent gyroscopeEventSum;

  StreamSubscription accelerometerEventSub;
  StreamSubscription userAccelerometerEventSub;
  StreamSubscription gyroscopeEventSub;

  _SensorsTestState() {
    accelerometerEventSub =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerometerEvent = event;
      });
    });
    userAccelerometerEventSub =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        userAccelerometerEvent = event;
      });
    });
    gyroscopeEventSub = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gyroscopeEvent = event;
        gyroscopeEventSum = (gyroscopeEventSum != null)
            ? GyroscopeEvent(gyroscopeEventSum.x + event.x,
                gyroscopeEventSum.y + event.y, gyroscopeEventSum.z + event.z)
            : event;
      });
    });
  }

  @override
  void dispose() {
    if (accelerometerEventSub != null) accelerometerEventSub.cancel();
    if (userAccelerometerEventSub != null) userAccelerometerEventSub.cancel();
    if (gyroscopeEventSub != null) gyroscopeEventSub.cancel();
    super.dispose();
  }

  String buildValue(value) {
    return value.toStringAsFixed(2);
  }

  Text buildEventData(event) {
    return (event != null)
        ? Text(
            "${buildValue(event.x)} ${buildValue(event.y)} ${buildValue(event.z)}")
        : Text("-");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text("Accelerometer"),
        buildEventData(accelerometerEvent),
        Text("UserAccelerometer"),
        buildEventData(userAccelerometerEvent),
        Text("GyroscopeEvent"),
        buildEventData(gyroscopeEvent),
        Text("GyroscopeEventSum"),
        buildEventData(gyroscopeEventSum),
      ],
    ));
  }
}
