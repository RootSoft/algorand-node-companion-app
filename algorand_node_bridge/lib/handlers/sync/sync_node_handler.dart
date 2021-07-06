import 'package:algorand_node_bridge/controllers/node_controller.dart';
import 'package:algorand_node_bridge/handlers/handlers.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

class SyncNodeHandler extends Handler {
  @override
  String get name => 'sync-node';

  @override
  Future<bool> resolve(Node node, Parameters parameters) async {
    return node.syncNode(fastCatchup: true);
  }
}
