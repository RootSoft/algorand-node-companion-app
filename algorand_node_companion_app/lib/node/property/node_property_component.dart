abstract class NodePropertyComponent {
  final String key;
  final String title;
  final String? value;
  final Map<String, dynamic> data;

  NodePropertyComponent({
    required this.key,
    required this.title,
    this.value,
    this.data = const {},
  });

  void addProperty(NodePropertyComponent component) {
    throw UnimplementedError();
  }

  NodePropertyComponent? findProperty(String key) {
    throw UnimplementedError();
  }
}
