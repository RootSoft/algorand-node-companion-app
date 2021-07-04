import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';

class RegisterOnlineHandler extends Handler {
  @override
  String get name => 'register-online';

  @override
  Future<Map<String, dynamic>> resolve(Node node, Parameters parameters) async {
    final address = parameters.asMap['address'];
    final rounds = parameters.asMap['rounds'];
    if (address == null || rounds == null) {
      throw RpcException(400, 'Invalid parameters');
    }

    // Generate a new participation key.
    await node.generateParticipationKey(
      address: address,
      rounds: rounds,
    );

    // Extract participation key info
    final partKeyInfo = await node.getPartKeyInfo(account: address);
    return partKeyInfo.toJson();
  }
}
