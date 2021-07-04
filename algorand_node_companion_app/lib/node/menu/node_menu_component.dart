import 'package:nodex_companion_app/themes/themes.dart';

abstract class NodeMenuComponent {
  final String key;
  final String title;
  final Widget? icon;
  final Map<String, dynamic> data;

  NodeMenuComponent({
    required this.key,
    required this.title,
    this.icon,
    this.data = const {},
  });

  void addMenuItem(NodeMenuComponent component) {
    throw UnimplementedError();
  }

  NodeMenuComponent? findMenuItem(String key) {
    throw UnimplementedError();
  }

  Future<bool> onTap(BuildContext context, {Function? error});
}
