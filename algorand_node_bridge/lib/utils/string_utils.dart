extension StringExtension on String {
  int extractNumber() {
    return int.tryParse(replaceAll(RegExp('[^0-9]'), '')) ?? 0;
  }

  String extractValue() {
    var idx = indexOf(':');
    if (idx == -1) {
      return this;
    }

    final parts = [substring(0, idx).trim(), substring(idx + 1).trim()];
    return parts.length > 1 ? parts[1] : this;
  }

  /// Clean a string by trimming it and removing new line chars.
  String clean() {
    return trim().replaceAll('\n', ' ');
  }
}

extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
