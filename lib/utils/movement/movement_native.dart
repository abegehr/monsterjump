import 'dart:async';

import 'movement.dart';
import 'package:sensors/sensors.dart';

class MovementNative implements Movement {
  final double sensorScaleNative = -5;

  StreamSubscription accelerometerEventSubNative;

  Function subHorizontalMovement(Function cb) {
    accelerometerEventSubNative =
        accelerometerEvents.listen((AccelerometerEvent event) {
      // Add scaled sensor data to horVel
      double horVel = event.x * sensorScaleNative;
      // callback horizontal velocity
      cb(horVel);
    });

    // return unsubscribe function
    return () {
      accelerometerEventSubNative.cancel();
    };
  }
}

Movement getMovement() => MovementNative();
