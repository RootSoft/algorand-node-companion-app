import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';
import 'package:nodex_server/models/node_status.dart';

/// Get a status report of the node.
class StatusCommand extends Handler {
  @override
  String get name => 'status';

  @override
  Future<Map<String, dynamic>> resolve(Node node, Parameters parameters) async {
    final response = <String, dynamic>{};
    final status = await node.status();
    response.addAll(status.toJson());

    if (status.status == NodeStatus.RUNNING ||
        status.status == NodeStatus.PARTICIPATING) {
      final keys = await node.getParticipationKeys();
      if (keys.isNotEmpty) {
        response['status'] = NodeStatus.PARTICIPATING.value;
        final participation =
            await node.getParticipationInformation(account: keys.first.account);
        response.addAll(participation);
      }
    }
    print(response);
    return response;
  }
}
