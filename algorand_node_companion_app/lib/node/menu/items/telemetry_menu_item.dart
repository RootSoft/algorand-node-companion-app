import 'dart:async';

import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/node/menu/node_menu_component.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:provider/provider.dart';

class TelemetricsMenuItem extends NodeMenuComponent {
  final bool enabled;
  TelemetricsMenuItem({required this.enabled})
      : super(
          key: 'telemetrics',
          title: enabled ? 'Enable telemetrics' : 'Disable telemetrics',
          icon: HeroIcon(
            HeroIcons.chartPie,
            color: Palette.secondaryTextColor,
          ),
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final node = context.read<NodeCardBloc>().state.node;
    final client = context.read<NodeCardBloc>().state.client;
    final c = Completer<bool>();
    client
        .enableTelemetry(!enabled)
        .then((stopped) => client.status(network: node.network, sync: true))
        .then((status) => c.complete(true))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }
}
