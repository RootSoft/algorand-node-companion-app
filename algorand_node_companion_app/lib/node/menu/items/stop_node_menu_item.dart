import 'dart:async';

import 'package:algorand_node_companion_app/node/menu/node_menu_component.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class StopNodeMenuItem extends NodeMenuComponent {
  StopNodeMenuItem()
      : super(
          key: 'stop-node',
          title: 'Stop node',
          icon: HeroIcon(
            HeroIcons.stop,
            color: Palette.secondaryTextColor,
          ),
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final node = context.read<NodeCardBloc>().state.node;
    final client = context.read<NodeCardBloc>().client;
    final c = Completer<bool>();
    client
        .stopNode(network: node.network)
        .then((stopped) => client.status(network: node.network, sync: true))
        .then((status) => c.complete(true))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }
}
