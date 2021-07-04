K enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
  bool lenient = false,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.firstWhere(
    (e) {
      final value = e.value;
      if (lenient && value is String && source is String) {
        return source.toLowerCase().contains(value.toLowerCase());
      }
      return e.value == source;
    },
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
  bool lenient = false,
}) {
  if (source == null) {
    return null;
  }
  return enumDecode<K, V>(
    enumValues,
    source,
    unknownValue: unknownValue,
    lenient: lenient,
  );
}
