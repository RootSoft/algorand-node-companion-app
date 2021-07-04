import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';

/// Start the node.
class StartNodeHandler extends Handler {
  @override
  String get name => 'start-node';

  @override
  Future<dynamic> resolve(Node node, Parameters parameters) {
    return node.start();
  }
}
