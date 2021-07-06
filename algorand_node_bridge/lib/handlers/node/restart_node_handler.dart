import 'dart:async';

import 'package:algorand_node_bridge/controllers/node_controller.dart';
import 'package:algorand_node_bridge/handlers/handlers.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

/// Restart the node.
class RestartNodeHandler extends Handler {
  @override
  String get name => 'restart-node';

  @override
  Future<dynamic> resolve(Node node, Parameters parameters) {
    return node.restart();
  }
}
