import 'dart:async';
import 'dart:io';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';
import 'package:nodex_server/models/node_network.dart';

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
