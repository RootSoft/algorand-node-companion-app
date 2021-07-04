import 'package:nodex_companion_app/node/menu/node_menu.dart';
import 'package:nodex_companion_app/node/menu/node_menu_items.dart';
import 'package:nodex_companion_app/shared/shared.dart';

/// A class used to separate the construction of complex menu's based on the status of a node.
class NodeMenuBuilder {
  NodeMenuBuilder();

  NodeMenu build([NodeInformation? information]) {
    final menu = NodeMenu();

    if (information == null) {
      return _buildDefaultMenuItems(menu);
    }

    final status = information.status;

    switch (status) {
      case NodeStatus.NOT_CONNECTED:
      case NodeStatus.CONNECTING:
        return _buildDefaultMenuItems(menu);
      case NodeStatus.RUNNING:
        return _buildRunningMenuItems(menu, information);
      case NodeStatus.NOT_RUNNING:
        return _buildNotRunningMenuItems(menu, information);
      case NodeStatus.SYNCING:
      case NodeStatus.SYNCING_FAST_CATCHUP:
        return _buildSyncingMenuItems(
          menu,
          information,
          isFastCatchup: status == NodeStatus.SYNCING_FAST_CATCHUP,
        );
      case NodeStatus.PARTICIPATING:
        return _buildParticipatingMenuItems(menu, information);
    }
  }

  NodeMenu _buildDefaultMenuItems(NodeMenu menu) {
    menu.addMenuItem(EditNodeMenuItem());
    menu.addMenuItem(ParticipateInConsensusMenuItem());
    menu.addMenuItem(RemoveNodeMenuItem());

    return menu;
  }

  NodeMenu _buildNotRunningMenuItems(
      NodeMenu menu, NodeInformation information) {
    menu.addMenuItem(StartNodeMenuItem());
    menu.addMenuItem(EditNodeMenuItem());
    menu.addMenuItem(ParticipateInConsensusMenuItem());
    menu.addMenuItem(SwitchNetworkMenuItem());
    menu.addMenuItem(RemoveNodeMenuItem());

    return menu;
  }

  NodeMenu _buildRunningMenuItems(NodeMenu menu, NodeInformation information) {
    menu.addMenuItem(StopNodeMenuItem());
    menu.addMenuItem(EditNodeMenuItem());
    menu.addMenuItem(ParticipateInConsensusMenuItem());
    menu.addMenuItem(RenewParticipationKeysMenuItem());
    menu.addMenuItem(TelemetricsMenuItem(enabled: information.telemetry));
    menu.addMenuItem(SwitchNetworkMenuItem());
    menu.addMenuItem(RemoveNodeMenuItem());

    return menu;
  }

  NodeMenu _buildSyncingMenuItems(
    NodeMenu menu,
    NodeInformation information, {
    bool isFastCatchup = false,
  }) {
    menu.addMenuItem(StopNodeMenuItem());
    menu.addMenuItem(EditNodeMenuItem());
    if (!isFastCatchup) {
      menu.addMenuItem(SyncNodeMenuItem());
    }
    menu.addMenuItem(ParticipateInConsensusMenuItem());
    menu.addMenuItem(TelemetricsMenuItem(enabled: information.telemetry));
    menu.addMenuItem(SwitchNetworkMenuItem());
    menu.addMenuItem(RemoveNodeMenuItem());

    return menu;
  }

  NodeMenu _buildParticipatingMenuItems(
    NodeMenu menu,
    NodeInformation information,
  ) {
    menu.addMenuItem(StopNodeMenuItem());
    menu.addMenuItem(EditNodeMenuItem());
    menu.addMenuItem(RegisterOfflineMenuItem());
    menu.addMenuItem(RenewParticipationKeysMenuItem());
    menu.addMenuItem(TelemetricsMenuItem(enabled: information.telemetry));
    menu.addMenuItem(SwitchNetworkMenuItem());
    menu.addMenuItem(RemoveNodeMenuItem());

    return menu;
  }
}
