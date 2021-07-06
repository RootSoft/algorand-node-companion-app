import 'dart:async';

import 'package:algorand_node_bridge/controllers/node_controller.dart';
import 'package:algorand_node_bridge/handlers/handlers.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

/// Stop the node.
class StopNodeHandler extends Handler {
  @override
  String get name => 'stop-node';

  @override
  Future<dynamic> resolve(Node node, Parameters parameters) {
    return node.stop();
  }
}
