import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/models/operating_system_model.dart';
import 'package:nodex_companion_app/node/menu/node_menu.dart';
import 'package:nodex_companion_app/node/menu/node_menu_builder.dart';
import 'package:nodex_companion_app/node/nodex_client.dart';
import 'package:nodex_companion_app/node/property/node_properties.dart';
import 'package:nodex_companion_app/node/property/node_property_builder.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/shared/shared.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_event.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_state.dart';
import 'package:nodex_companion_app/ui/screens/nodes/my_nodes.dart';

class NodeCardBloc extends Bloc<NodeCardEvent, NodeCardState> {
  final NodeRepository _nodeRepository;
  StreamSubscription? _statusSubscription;

  // Subscription to node updates
  late StreamSubscription _nodesSubscription;

  NodeCardBloc({
    required Node node,
    required NodeRepository nodeRepository,
    required Stream stream,
  })  : _nodeRepository = nodeRepository,
        super(
          NodeCardState(
            node: node,
            client: NodeXClient(),
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
    final client = state.client;
    if (event is NodeCardStarted || event is NodeCardConnectStarted) {
      yield* _mapConnectToState(node: node, client: client);
    }

    if (event is NodeCardStatusUpdated) {
      yield* _mapStatusToState(node: node, client: client);
    }

    if (event is NodeCardNetworkSwitched) {
      yield* _mapNetworkSwitchToState(
        node: node,
        client: client,
        network: event.network,
      );
    }
  }

  Stream<NodeCardState> _mapConnectToState({
    required Node node,
    required NodeXClient client,
  }) async* {
    final currentState = state;
    try {
      yield currentState.copyWith(
        node: node.copyWith(status: NodeStatus.CONNECTING),
      );

      await client.connect(node.ipAddress, node.port, node.workingDirectory);
      final data = await client.handshake();
      final os = parseOperatingSystem(data['operating-system']);
      final nodex = node.copyWith(operatingSystem: os);

      // Store the OS
      await _nodeRepository.save(nodex);

      yield currentState.copyWith(
        menu: NodeMenuBuilder().build(),
      );

      // Map the status to the state
      yield* _mapStatusToState(
        node: nodex,
        client: client,
      );

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
    required NodeXClient client,
    required NodeNetwork network,
  }) async* {
    final success = await client.switchNetwork(network: network);
    if (success) {
      final switchedNode = node.copyWith(network: network);
      await _nodeRepository.save(switchedNode);

      yield* _mapStatusToState(
        node: switchedNode,
        client: client,
      );
    }
  }

  Stream<NodeCardState> _mapStatusToState({
    required Node node,
    required NodeXClient client,
  }) async* {
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
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _nodesSubscription.cancel();
    return super.close();
  }
}
