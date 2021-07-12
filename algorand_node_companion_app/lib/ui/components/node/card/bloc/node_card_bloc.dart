import 'dart:async';

import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/models/operating_system_model.dart';
import 'package:algorand_node_companion_app/node/menu/node_menu.dart';
import 'package:algorand_node_companion_app/node/menu/node_menu_builder.dart';
import 'package:algorand_node_companion_app/node/nodex_client.dart';
import 'package:algorand_node_companion_app/node/property/node_properties.dart';
import 'package:algorand_node_companion_app/node/property/node_property_builder.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';
import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:algorand_node_companion_app/ui/components/node/card/bloc/node_card_event.dart';
import 'package:algorand_node_companion_app/ui/components/node/card/bloc/node_card_state.dart';
import 'package:algorand_node_companion_app/ui/screens/nodes/my_nodes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NodeCardBloc extends Bloc<NodeCardEvent, NodeCardState> {
  final NodeXClient client;
  final NodeRepository _nodeRepository;
  StreamSubscription? _statusSubscription;

  // Subscription to node updates
  late StreamSubscription _nodesSubscription;

  // Subscription to connection changes
  late StreamSubscription _connectionSubscription;

  NodeCardBloc({
    required Node node,
    required NodeRepository nodeRepository,
    required this.client,
    required Stream stream,
  })  : _nodeRepository = nodeRepository,
        super(
          NodeCardState(
            node: node,
            menu: NodeMenu(),
            properties: NodeProperties(),
          ),
        ) {
    _buildNodesSubscription(stream);
  }

  void start() {
    add(NodeCardStarted());
  }

  void refresh() {
    add(NodeCardStarted());
  }

  void connect() {
    add(NodeCardConnectStarted());
  }

  void switchNetwork({required NodeNetwork network}) {
    add(NodeCardNetworkSwitched(network: network));
  }

  @override
  Stream<NodeCardState> mapEventToState(NodeCardEvent event) async* {
    final node = state.node;
    if (event is NodeCardStarted || event is NodeCardConnectStarted) {
      yield* _mapConnectToState(node: node);
    }

    if (event is NodeCardStatusUpdated) {
      yield* _mapStatusToState(node: node);
    }

    if (event is NodeCardNetworkSwitched) {
      yield* _mapNetworkSwitchToState(node: node, network: event.network);
    }
  }

  Stream<NodeCardState> _mapConnectToState({
    required Node node,
  }) async* {
    final currentState = state;
    try {
      yield currentState.copyWith(
        node: node.copyWith(status: NodeStatus.CONNECTING),
      );

      // Connect with ANB
      await client.connect(
        node.ipAddress,
        port: node.port,
        useSSL: node.useSSL,
        token: node.token,
        workingDirectory: node.workingDirectory,
      );

      final data = await client.handshake();
      final os = parseOperatingSystem(data['operating-system']);
      final nodex = node.copyWith(operatingSystem: os);

      // Store the OS
      await _nodeRepository.save(nodex);

      yield currentState.copyWith(
        menu: NodeMenuBuilder().build(),
      );

      // Map the status to the state
      yield* _mapStatusToState(node: nodex);

      _buildStatusSubscription(client.statusUpdateChanges);
    } catch (ex) {
      yield currentState.copyWith(
        node: node.copyWith(status: NodeStatus.NOT_CONNECTED),
        menu: NodeMenuBuilder().build(),
      );
    }
  }

  Stream<NodeCardState> _mapNetworkSwitchToState({
    required Node node,
    required NodeNetwork network,
  }) async* {
    final success = await client.switchNetwork(network: network);
    if (success) {
      final switchedNode = node.copyWith(network: network);
      await _nodeRepository.save(switchedNode);

      yield* _mapStatusToState(
        node: switchedNode,
      );
    }
  }

  Stream<NodeCardState> _mapStatusToState({required Node node}) async* {
    try {
      final information = await client.status(network: node.network);
      yield state.copyWith(
        node: node.copyWith(
          status: information.status,
          latestBlock: information.latestBlock,
          version: information.currentVersion,
          network: information.network,
          syncTime: information.syncTime,
          telemetry: information.telemetry,
        ),
        menu: NodeMenuBuilder().build(information),
        properties: NodePropertyBuilder(information: information).build(),
      );
    } catch (ex) {
      yield state.copyWith(
        node: node.copyWith(status: NodeStatus.NOT_CONNECTED),
        menu: NodeMenuBuilder().build(),
      );
    }
  }

  void _buildStatusSubscription(Stream<int> stream) {
    _statusSubscription?.cancel();
    _statusSubscription = stream.listen((status) {
      add(NodeCardStatusUpdated());
    });
  }

  void _buildNodesSubscription(Stream stream) {
    _nodesSubscription = stream.listen((state) {
      if (state is MyNodesRefreshed) {
        refresh();
      }
    });

    _connectionSubscription = client.connectionStateChanges.listen((success) {
      if (!success) add(NodeCardStatusUpdated());
    });
  }

  @override
  Future<void> close() {
    client.close();
    _statusSubscription?.cancel();
    _connectionSubscription.cancel();
    _nodesSubscription.cancel();
    return super.close();
  }
}
