import 'package:nodex_companion_app/node/menu/node_menu_component.dart';
import 'package:nodex_companion_app/themes/themes.dart';

class NodeMenu extends NodeMenuComponent {
  final List<NodeMenuComponent> all = [];

  NodeMenu({
    String key = '',
    String title = '',
  }) : super(key: key, title: title);

  @override
  void addMenuItem(NodeMenuComponent component) {
    this.all.add(component);
  }

  @override
  NodeMenuComponent? findMenuItem(String key) {
    return this.all.firstWhere(
          (menuItem) => menuItem.key == key,
          orElse: null,
        );
  }

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    return Future.value(false);
  }
}
