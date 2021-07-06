import 'package:algorand_node_bridge/controllers/node_controller.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

abstract class Handler {
  String get name;

  Future<dynamic> resolve(Node node, Parameters parameters);
}
