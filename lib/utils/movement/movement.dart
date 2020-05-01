import 'movement_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'movement_native.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'movement_web.dart';

abstract class Movement {
  Function subHorizontalMovement(Function cb) {
    return () {}; // return unsubscribe function
  }

  /// factory constructor to return the correct implementation.
  factory Movement() => getMovement();
}
