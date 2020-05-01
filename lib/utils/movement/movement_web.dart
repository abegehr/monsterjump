import 'movement.dart';
import 'dart:html'; //TODO use universal_html? https://stackoverflow.com/q/60646793/499113
import 'package:js/js.dart';

// ignore: missing_js_lib_annotation
@JS("requestDeviceMotionEventPermission")
external void requestDeviceMotionEventPermission();

class MovementNative implements Movement {
  final double sensorScaleWeb = 3.66;

  EventListener accelerometerListenerWeb;

  Function subHorizontalMovement(Function cb) {
    accelerometerListenerWeb = (event) {
      if (event is DeviceMotionEvent &&
          event.accelerationIncludingGravity != null &&
          event.accelerationIncludingGravity.x != null) {
        // Add scaled sensor data to horVel
        double horVel = event.accelerationIncludingGravity.x * sensorScaleWeb;
        // callback horizontal velocity
        cb(horVel);
      }
    };

    // TODO move logic to dart once DeviceMotionEvent.requestPermission() is supported: https://github.com/dart-lang/sdk/issues/41337
    requestDeviceMotionEventPermission();

    document.window.addEventListener('devicemotion', accelerometerListenerWeb);

    // return unsubscribe function
    return () {
      document.window
          .removeEventListener('devicemotion', accelerometerListenerWeb);
    };
  }
}

Movement getMovement() => MovementNative();
