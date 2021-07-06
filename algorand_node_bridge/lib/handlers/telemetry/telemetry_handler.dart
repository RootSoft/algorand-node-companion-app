import 'dart:async';

import 'package:algorand_node_bridge/controllers/node_controller.dart';
import 'package:algorand_node_bridge/handlers/handlers.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

class TelemetryHandler extends Handler {
  @override
  String get name => 'enable-telemetry';

  @override
  Future<dynamic> resolve(Node node, Parameters parameters) {
    final enable = parameters.asMap['enable'] ?? false;

    // Enable/disable telemetry
    return node.enableTelemetry(enable);
  }
}
