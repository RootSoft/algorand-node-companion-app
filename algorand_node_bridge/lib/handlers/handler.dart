import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';

abstract class Handler {
  String get name;

  Future<dynamic> resolve(Node node, Parameters parameters);
}
