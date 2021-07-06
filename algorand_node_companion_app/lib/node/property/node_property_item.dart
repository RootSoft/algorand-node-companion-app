import 'package:algorand_node_companion_app/node/property/node_property_component.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';

class NodePropertyItem extends NodePropertyComponent {
  NodePropertyItem({
    required String key,
    required String title,
    String? value,
    Color? color,
  }) : super(
          key: key,
          title: title,
          value: value,
          data: {'color': color},
        );
}
