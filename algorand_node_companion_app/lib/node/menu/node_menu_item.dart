import 'package:nodex_companion_app/node/menu/node_menu_component.dart';
import 'package:nodex_companion_app/themes/themes.dart';

typedef TapCallback = Future<bool> Function(BuildContext context, {Function? error});

class NodeMenuItem extends NodeMenuComponent {

  NodeMenuItem({
    required String key,
    required String title,
    Widget? icon,
    Map<String, dynamic> data = const {},
  })  : super(
          key: key,
          title: title,
          icon: icon,
          data: data,
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    throw UnimplementedError();
  }
}
