import 'dart:async';

import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/node/menu/node_menu_component.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:provider/provider.dart';

class SyncNodeMenuItem extends NodeMenuComponent {
  SyncNodeMenuItem()
      : super(
          key: 'sync-node',
          title: 'Sync node (with Fast Catchup)',
          icon: HeroIcon(
            HeroIcons.fastForward,
            color: Palette.secondaryTextColor,
          ),
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final node = context.read<NodeCardBloc>().state.node;
    final client = context.read<NodeCardBloc>().state.client;
    final c = Completer<bool>();
    client
        .syncNode(network: node.network, fastCatchup: true)
        .then((stopped) => client.status(network: node.network, sync: true))
        .then((status) => c.complete(true))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }
}
