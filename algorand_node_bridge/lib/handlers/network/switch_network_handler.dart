import 'dart:async';
import 'dart:io';

import 'package:algorand_node_bridge/controllers/node_controller.dart';
import 'package:algorand_node_bridge/handlers/handlers.dart';
import 'package:algorand_node_bridge/models/node_network.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

class SwitchNetworkHandler extends Handler {
  @override
  String get name => 'switch-network';

  @override
  Future<bool> resolve(Node node, Parameters parameters) {
    final network = node.network;
    final workingDirectory = node.workingDirectory;

    final genesisFile = File('$workingDirectory/${network.data}/genesis.json');

    // Check if destination files exists, if not create them
    if (genesisFile.existsSync()) {
      return Future.value(true);
    }

    return node.switchNetwork(network: network);
  }
}
