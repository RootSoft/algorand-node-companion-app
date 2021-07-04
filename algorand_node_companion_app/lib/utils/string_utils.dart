extension StringUtils on String {
  String toShortenedAddress([int count = 6]) {
    return '${take(count)}...${takeLast(count)}';
  }

  /// Returns a string containing the first [n] characters from this string, or the entire string if this string is shorter.
  ///
  /// @throws IllegalArgumentException if [n] is negative.
  ///
  /// @sample samples.text.Strings.take
  String take(int n) {
    return substring(0, n.coerceAtMost(length));
  }

  /// Returns a string containing the first [n] characters from this string, or the entire string if this string is shorter.
  ///
  /// @throws IllegalArgumentException if [n] is negative.
  ///
  /// @sample samples.text.Strings.take
  String takeLast(int n) {
    return substring(length - n.coerceAtMost(length), length);
  }
}

extension NumCoerceAtMostExtension<T extends num> on T {
  /// Ensures that this value is not greater than the specified [maximumValue].
  ///
  /// Return this value if it's less than or equal to the [maximumValue] or the
  /// [maximumValue] otherwise.
  ///
  /// ```dart
  /// print(10.coerceAtMost(5)) // 5
  /// print(10.coerceAtMost(20)) // 10
  /// ```
  T coerceAtMost(T maximumValue) => this > maximumValue ? maximumValue : this;
}
