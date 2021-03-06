import 'dart:async';

import 'package:algorand_node_companion_app/node/menu/node_menu_component.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class TelemetryMenuItem extends NodeMenuComponent {
  final bool enabled;
  TelemetryMenuItem({required this.enabled})
      : super(
          key: 'telemetry',
          title: enabled ? 'Enable telemetry' : 'Disable telemetry',
          icon: HeroIcon(
            HeroIcons.chartPie,
            color: Palette.secondaryTextColor,
          ),
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final node = context.read<NodeCardBloc>().state.node;
    final client = context.read<NodeCardBloc>().client;
    final c = Completer<bool>();
    client
        .enableTelemetry(!enabled)
        .then((stopped) => client.status(network: node.network, sync: true))
        .then((status) => c.complete(true))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }
}
