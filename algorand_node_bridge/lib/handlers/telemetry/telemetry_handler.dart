import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';

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
