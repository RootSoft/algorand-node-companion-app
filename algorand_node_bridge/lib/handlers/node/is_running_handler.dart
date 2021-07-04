import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';

/// Check if the node is running.
class IsRunningHandler extends Handler {
  @override
  String get name => 'is-node-running';

  @override
  Future<dynamic> resolve(Node node, Parameters parameters) {
    return node.isRunning();
  }
}
