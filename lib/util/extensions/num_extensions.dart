import 'dart:math';

extension NumExtensions on num {
  /// Returns this number as a string, padding it with leading 0s to make sure
  /// its at least [numDigits] long
  String toStringWithZeroPadding(int numDigits) {
    String leading0s = "";
    // int digitCounter =
    for (int i = numDigits - 1; i > 0; i--) {
      var digit = pow(10, i);

      if (this < digit) {
        leading0s += "0";
      } else {
        break;
      }
    }
    return "$leading0s$this";
  }
}
