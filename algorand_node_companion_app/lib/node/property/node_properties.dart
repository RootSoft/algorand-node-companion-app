import 'package:algorand_node_companion_app/node/property/node_property_component.dart';

class NodeProperties extends NodePropertyComponent {
  final List<NodePropertyComponent> all = [];

  NodeProperties({
    String key = '',
    String title = '',
  }) : super(key: key, title: title);

  @override
  void addProperty(NodePropertyComponent component) {
    this.all.add(component);
  }

  @override
  NodePropertyComponent? findProperty(String key) {
    try {
      return this.all.firstWhere((property) => property.key == key);
    } on StateError {
      return null;
    }
  }
}
