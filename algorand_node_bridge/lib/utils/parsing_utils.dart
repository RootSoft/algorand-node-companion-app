import 'package:algorand_node_bridge/models/status_property.dart';

extension ParserExtension on List<String> {
  String findProperty(StatusProperty property) {
    return firstWhere(
      (line) => line.toLowerCase().startsWith(
            property.property.toLowerCase(),
          ),
      orElse: () => '',
    );
  }
}
