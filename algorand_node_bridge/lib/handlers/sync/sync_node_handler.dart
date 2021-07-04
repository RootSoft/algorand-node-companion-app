import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';

class SyncNodeHandler extends Handler {
  @override
  String get name => 'sync-node';

  @override
  Future<bool> resolve(Node node, Parameters parameters) async {
    return node.syncNode(fastCatchup: true);
  }
}
